aws-k8s-bootstrap
=================

Create VPC, Internet gateway, Subnets, Route tables, Security groups, and EC2 Instances for [kubespray](https://github.com/kubernetes-incubator/kubespray).

Requirements
------------

- boto
- boto3
- botocore

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.


Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

For awscli

| Name                  | Explain                        |
|:----------------------|:-------------------------------|
| aws_access_key_id     | Access Key for AWS API.        |
| aws_secret_access_key | Secret Access Key for AWS API. |
| aws_default_region    | Default Region                 |

For AWS

| Name                                | Explain                          |
|:------------------------------------|:---------------------------------|
| env                                 | Environment name for k8s cluster |
| aws_k8s_default_ami                 | AMI ID for ec2 create instance   |
| aws_k8s_bootstrap_iam_policy_master | Policy name for k8s master       |
| aws_k8s_bootstrap_iam_policy_minion | Policy name for k8s node         |
| aws_k8s_bootstrap_iam_role_master   | Role name for k8s master         |
| aws_k8s_bootstrap_iam_role_minion   | Role name for k8s node           |
| aws_k8s_bootstrap:                  | -------------------------------- |
| - vpc:                              |	-------------------------------- |
| -   name                            | VPC Name                         |
| -   cidr_block                      | IPv4 CIDR Block for VPC          |
| - igw:                              | -------------------------------- |
| -   name                            | Internet Gateway name            |
| - subnets:                          | __Array__                        |
| -   name                            | Subnet name                      |
| -   cidr                            | Subnet CIDR Block                |
| -   az                              | Subnet availability zone         |
| -   map_public                      | { yes \| no } for public subnet  |
| - security_group:                   | __Array__                        |
| -   name                            | Security Group name              |
| -  description                      | Security Group description       |
| -   rules:                          | __Array__                        |
| -     proto                         | Protocol                         |
| _choice_                            | -------------------------------- |
| -     from_port                     | From port                        |
| -     to_port                       | To port                          |
| _or_                                | -------------------------------- |
| -     ports                         | __Array__ : Port number          |
| _end_                               | -------------------------------- |
| -     cidr_ip                       | __Array__ : CIDR Block           |
| -     group_desc                    | Rule description                 |
| - instances:                        | __Array__                        |
| -   name                            | EC2 Instance name                |
| -   cidr                            | Subnet CIDR Block                |
| -   count                           | Number of EC2 instances          |
| -   key_pair                        | SSH Key pair name                |
| -   ami                             | AMI ID                           |
| -   instance_type                   | EC2 Instance type                |
| -   profile                         | Instance profile name            |
| -   security_group                  | __Array__ : Security groups      |
| -   kubespray_role                  | Role for Kubespray { basition \| ansible \| kube-master \| etcd \| kube-node } |
| -   volume_size                     | EBS Volume size (GB)             |


Dependencies
------------

- aws-credentials

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: us-west-2-experimental
      gather_facts: no
      vars:
        env: Experimental
      roles:
         - aws-credentials
	 - aws-k8s-bootstrap

License
-------

MIT

Author Information
------------------

toshiki.hayashi ＠ outlook.com
