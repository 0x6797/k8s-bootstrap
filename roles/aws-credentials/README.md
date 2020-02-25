aws-credentials
===============

Check if configure environment variables for AWS CLI or `aws configure`.

Requirements
------------

- awk
- awscli

Define environments variables as follows.

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCEESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="us-west-2"
```

Or execute `aws configure`.

Role Variables
--------------

| Name                  | Explain                        |
|:----------------------|:-------------------------------|
| aws_access_key_id     | Access Key for AWS API.        |
| aws_secret_access_key | Secret Access Key for AWS API. |
| aws_default_region    | Default Region                 |

Dependencies
------------

None.

Example Playbook
----------------

    - hosts: localhost
      gather_facts: no
      roles:
         - aws-credentials

License
-------

MIT

Author Information
------------------

toshiki.hayashi ＠ outlook.com
