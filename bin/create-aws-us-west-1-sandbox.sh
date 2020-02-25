#!/bin/bash

set -eu

export ENV=sandbox
export REGION=us-west-1
export PROVIDER=aws
export SECRET_KEY_NAME=bitx-ncalifornia-key

ROOT_DIR=$(echo $(dirname $(readlink -f $0 || echo $0)) | sed -e s:/bin\$::)

pushd $ROOT_DIR

ansible-playbook -i inventory/local.ini provision-aws-infrastructure.yaml
ansible-playbook --private-key=~/.ssh/${SECRET_KEY_NAME}.pem -i inventory/aws/${REGION}-${ENV}.ini bastion.yaml

popd

