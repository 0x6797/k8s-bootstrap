#!/bin/bash

set -eu

export ENV=experimental
export REGION=us-west-1

ROOT_DIR=$(echo $(dirname $(readlink -f $0 || echo $0)) | sed -e s:/bin\$::)

pushd $ROOT_DIR

ansible-playbook -i inventory/local.ini provision-aws-infrastructure.yaml

popd
