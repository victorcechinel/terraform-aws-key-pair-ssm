# AWS Key Pair SSM

![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13.6-blue.svg) [![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Terraform Module to create an AWS Key Pair and store credentials on Parameter Store.

## Features

This Terraform module creates the following AWS resources:

* **Key Pair**: Key Pair;
* **Parameter Store**
  * TLS Private Key;
  * TLS Public Key (OpenSSH - RSA);
  * TLS Public Key;

## Requirements

* This module is meant for use with [Terraform](https://www.terraform.io/downloads.html) 0.13+. It has not been tested with previous versions of Terraform.
* An AWS account and your credentials (`aws_access_key_id` and `aws_secret_access_key`) configured. There are several ways to do this (environment variables, shared credentials file, etc.): my preference is to store them in a [credential file](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). More information in the [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html) documentation.

## Usage

```HCL
terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      region  = "sa-east-1"
      shared_credentials_file = "~/.aws/credentials"
    }
  }
}

module "aws_rds_postgres" {
  source = "victorcechinel/key-pair-ssm/aws"

  name = "key-pair-name"
}
```

## Inputs

| Name | Description   | Type          | Default | Required |
| ---- | ------------- | ------------- | ------- | -------- |
| name | Key Pair name | string        | -       | yes      |
| tags | Tags          | array(string) | -       | no       |

## Outputs

| Name               | Description                         |
| ------------------ | ----------------------------------- |
| key_pair_name      | Name key pair                       |
| tls_private_ssm    | TLS Private Key SSM name            |
| tls_public_rsa_ssm | TLS Public Key (OpenSSH - RSA) name |
| tls_public_ssm     | TLS Public Key name                 |

## Author

Module written by [@victorcechinel](https://github.com/victorcechinel). 
[Linkedin](https://www.linkedin.com/in/victorcechinelr/). 
Module Support: [terraform-aws-keypair-ssm](https://github.com/victorcechinel/terraform-aws-keypair-ssm). 
Contributions and comments are welcomed.