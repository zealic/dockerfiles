#!/bin/bash
if [ ! -f /etc/ocserv/server-key.pem ] || [ ! -f /etc/ocserv/server-cert.pem ]; then
	# Check environment variables
	if [ -z "$CA_CN" ]; then
		CA_CN="Great Water Mall CA"
	fi

	if [ -z "$CA_ORG" ]; then
		CA_ORG="Big Brother"
	fi

	if [ -z "$CA_DAYS" ]; then
		CA_DAYS=9999
	fi

	if [ -z "$SRV_CN" ]; then
		SRV_CN="www.example.com"
	fi

	if [ -z "$SRV_ORG" ]; then
		SRV_ORG="Big Brother"
	fi

	if [ -z "$SRV_DAYS" ]; then
		SRV_DAYS=9999
	fi

	# No certification found, generate one
	cd /etc/ocserv
	certtool --generate-privkey --outfile ca-key.pem
	cat > ca.tmpl <<-EOCA
	cn = "$CA_CN"
	organization = "$CA_ORG"
	serial = 1
	expiration_days = $CA_DAYS
	ca
	signing_key
	cert_signing_key
	crl_signing_key
	EOCA
	certtool --generate-self-signed --load-privkey ca-key.pem --template ca.tmpl --outfile ca.pem
	certtool --generate-privkey --outfile server-key.pem 
	cat > server.tmpl <<-EOSRV
	cn = "$SRV_CN"
	organization = "$SRV_ORG"
	expiration_days = $SRV_DAYS
	signing_key
	encryption_key
	tls_www_server
	EOSRV
	certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem

	# Create a test user
	if [ -z "$NO_TEST_USER" ] && [ ! -f /etc/ocserv/ocpasswd ]; then
		echo "Create test user 'test' with password 'test'"
		echo 'test:*:$5$DktJBFKobxCFd7wN$sn.bVw8ytyAaNamO.CvgBvkzDiFR6DaHdUzcif52KK7' > /etc/ocserv/ocpasswd
	fi
fi

# Enable TUN device
if [[ ! -e /dev/net/tun ]]; then
  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200
  chmod 600 /dev/net/tun
fi

# Setup config
if [[ ! -f /etc/ocserv/ocserv.conf ]]; then
  cp /etc/ocserv/simple.config /etc/ocserv/ocserv.conf
  sed -i 's/\.\/sample\.passwd/\/etc\/ocserv\/ocpasswd/' /etc/ocserv/ocserv.conf
  sed -i 's/\(max-same-clients = \)2/\110/' /etc/ocserv/ocserv.conf
  sed -i 's/\.\.\/tests/\/etc\/ocserv/' /etc/ocserv/ocserv.conf
  sed -i 's/#\(compression.*\)/\1/' /etc/ocserv/ocserv.conf
  sed -i '/^ipv4-network = /{s/192.168.1.0/192.168.99.0/}' /etc/ocserv/ocserv.conf
  sed -i 's/192.168.1.2/8.8.8.8/' /etc/ocserv/ocserv.conf
  sed -i 's/^route/#route/' /etc/ocserv/ocserv.conf
  sed -i 's/^no-route/#no-route/' /etc/ocserv/ocserv.conf
fi

# LDAP config
if [[ ! -z "${LDAP_SERVER}" ]]; then
  cat > /etc/pam_ldap.conf <<EOF
ldap_version 3
uri ${LDAP_SERVER}
base ${LDAP_BASEDN}
binddn ${LDAP_BINDDN}
bindpw ${LDAP_BINDPW}
EOF
  if [[ ! -z "${LDAP_GROUPDN}" ]]; then
    echo "pam_groupdn ${LDAP_GROUPDN}" >> /etc/pam_ldap.conf
    echo "pam_member_attribute ${LDAP_MEMBER_ATTRIBUTE:-member}" >> /etc/pam_ldap.conf
  fi
  if [[ ! -z "${LDAPTLS_CACERTDIR}" ]]; then
    echo "tls_cacertdir ${LDAPTLS_CACERTDIR}" >> /etc/pam_ldap.conf
  elif [[ ! -z "${LDAPTLS_CACERT}" ]]; then
    echo "tls_cacertfile ${LDAPTLS_CACERT}" >> /etc/pam_ldap.conf
  elif [[ ! -z "LDAPTLS_CHECKPEER" ]]; then
    echo "tls_checkpeer ${LDAPTLS_CHECKPEER}" >> /etc/pam_ldap.conf
  fi

  if [[ ! -z "RFC2307" ]]; then
    cat >> /etc/pam_ldap.conf <<EOF
pam_login_attribute ${LDAP_LOGIN_ATTRIBUTE:-sAMAccountName}
pam_filter objectclass=User
pam_password ad
EOF
  fi

  if [[ ! -d /etc/pam_ldap.d ]]; then
    for conf in /etc/pam_ldap.d/*.conf; do
      cat $conf >> /etc/pam_ldap.conf
    done
  fi
fi

# Open ipv4 ip forward
sysctl -w net.ipv4.ip_forward=1

# Enable NAT forwarding
echo "1" | update-alternatives --config iptables
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

# Run OpennConnect Server
exec "$@"
