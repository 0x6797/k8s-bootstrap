#!/bin/bash

set -eu

export ENV=sandbox
export REGION=us-east-2
export PROVIDER=aws
export SECRET_KEY_NAME=bitx-kubernetes-cluster

ROOT_DIR=$(echo $(dirname $(readlink -f $0 || echo $0)) | sed -e s:/bin\$::)

pushd $ROOT_DIR

ansible-playbook --private-key=~/.ssh/${SECRET_KEY_NAME}.pem -i inventory/aws/${REGION}-${ENV}.ini bastion.yaml

popd


