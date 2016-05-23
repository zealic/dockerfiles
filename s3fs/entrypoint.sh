#!/bin/sh
if [[ -z $AWS_ACCESS_KEY_ID ]]; then
  echo "Environment variable 'AWS_ACCESS_KEY_ID' is required."
  exit 1
fi
if [[ -z $AWS_SECRET_KEY_ID ]]; then
  echo "Environment variable 'AWS_SECRET_KEY_ID' is required."
  exit 1
fi
echo $AWS_ACCESS_KEY_ID:$AWS_SECRET_KEY_ID > /etc/passwd-s3fs
chmod 400 /etc/passwd-s3fs

CAPS=`getpcaps 0 2>&1`
if [[ `echo $CAPS | grep -c "cap_sys_admin" ` -eq 0 ]]; then
  echo "Capability 'sys_admin' is required."
  exit 1
fi
if [[ `echo $CAPS | grep -c "mknod" ` -eq 0 ]]; then
  echo "Capability 'sys_admin' is required."
  exit 1
fi

exec /usr/bin/s3fs "$@"
