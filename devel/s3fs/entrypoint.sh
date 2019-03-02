#!/bin/sh
if [[ -z "$@" ]]
  if [[ -z $S3_BUCKET ]]; then
    echo "Environment variable 'S3_BUCKET' is required."
    exit 1
  fi
  if [[ -z $MOUNT_POINT ]]; then
    echo "Environment variable 'MOUNT_POINT' is required."
    exit 1
  fi
  if [[ -z $AWS_ACCESS_KEY_ID ]]; then
    echo "Environment variable 'AWS_ACCESS_KEY_ID' is required."
    exit 1
  fi
  if [[ -z $AWS_SECRET_ACCESS_KEY ]]; then
    echo "Environment variable 'AWS_SECRET_ACCESS_KEY' is required."
    exit 1
  fi
  export AWSACCESSKEYID=$AWS_ACCESS_KEY_ID
  export AWSSECRETACCESSKEY=$AWS_SECRET_ACCESS_KEY
fi

if [[ ! -e /dev/fuse ]]; then
  mknod /dev/fuse c 0 0
fi

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
