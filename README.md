iot-k8s-bootsrap
================

Kubernets(k8s) クラスターに必要な構成要素を作成するための Playbook です。

- Kubernetes クラスタに必要な構成要素を作成します
  - AWS
    - VPC
    - Internet Gateway
    - IAM
      - Policy
      - Role
    - Subnet
      - Public
      - Private
    - NAT Gateway
      - Public subnet * Availavility Zones
    - Route Table
      - Public * 1
      - Private * Private Subnets
    - Elastic Load Balancer
    - Elastic IP
      - Bastion * Availavility Zones
    - Security Group
      - Bastion
      - Kubernetes Master and Etcd
      - Kubernetes Worker
    - EC2 Instance
      - Bastion * Availavility Zones
      - Kubernetes Master
      - Etcd
      - Kubernetes Worker
- Bastion(踏み台)サーバに Kubespray をインストールします

Requirement
-----------

- Python >= 2.6
- Git
- Ansible >= 2.6
- AWS CLI

Ansible をインストールする
--------------------------

Playbook を実行するマシンに Ansible をインストールします。

```bash
$ sudo yum install -y python python2-pip
$ sudo pip install --user ansible
```

AWS | aws cli を実行する
------------------------

`aws configure` を実行して、アクセスキーとシークレットキーなどを設定しておきます。

AWS | EC2 Key Pair を作成する
-----------------------------

あらかじめ、k8s クラスターで使用するEC2キーペアを作成しておく必要があります。

作成した秘密鍵は`~/.ssh/` ディレクトリにコピーして置く必要があります。

Playbook を実行する
-------------------

`./bin` ディレクトリにある、スクリプトを実行します。

AWS の us-west-1 に sandbox 環境を作成する場合は、以下のように実行します。

```bash
$ ./bin/create-aws-us-west-1-sandbox.sh
```

Playbook を実行した環境で bastion(踏み台)サーバと、k8s の各クラスター構成要素が作成されます。

例えば、AWS のus-west-1 で sandbox 環境を構築した場合は Availability Zone が 2つ なので、以下のような構成要素になります。

| 名前                         | Availavility Zone | 備考            |
|:-----------------------------|:------------------|:----------------|
| sandbox-kubernetes-bastion-0 | us-west-1a        | Elastic IP 付与 |
| sandbox-kubernetes-bastion-1 | us-west-1c        | Elastic IP 付与 |
| sandbox-kubernetes-master-0  | us-west-1a        |                 |
| sandbox-kubernetes-master-1  | us-west-1c        |                 |
| sandbox-kubernetes-master-2  | us-west-1a        |                 |
| sandbox-kubernetes-etcd-0    | us-west-1a        |                 |
| sandbox-kubernetes-etcd-1    | us-west-1c        |                 |
| sandbox-kubernetes-etcd-2    | us-west-1a        |                 |
| sandbox-kubernetes-minion-0  | us-west-1a        |                 |
| sandbox-kubernetes-minion-1  | us-west-1c        |                 |
| sandbox-kubernetes-mimion-2  | us-west-1a        |                 |
| sandbox-kubernetes-minion-3  | us-west-1c        |                 |

Kubespray を実行する
--------------------

Bastion(踏み台)サーバに `SSH` でログインします。

```bash
$ ssh -i <ssh key file> ec2-user@<bastion ip>
```

Kubespray を実行します

```bash
$ cd ~/kubespray
$ ansible-playbook -i inventory/hosts.py cluster.yml -b
```

Kubespray 実行後に Kubernetes クラスタが作成されます。
