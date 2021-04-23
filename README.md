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

The credentials will be **saved** to the *SSM Parameter Store* as follows:
* /ec2/key-pair/name/private-rsa-key-pem
* /ec2/key-pair/name/public-rsa-key-pem
* /ec2/key-pair/name/public-rsa-key-openssh
  
*The name is sent in the parameter to the module.*

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
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region                  = "sa-east-1"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_rds_postgres" {
  source  = "victorcechinel/key-pair-ssm/aws"
  version = "1.0.1"
  
  name = "key-pair-name"
}
```

## Inputs

| Name | Description   | Type   | Default | Required |
| ---- | ------------- | ------ | ------- | -------- |
| name | Key Pair name | string | -       | yes      |
| tags | Tags          | array  | -       | no       |

## Outputs

| Name               | Description                         |
| ------------------ | ----------------------------------- |
| key_pair_name      | Name key pair                       |
| tls_private_ssm    | TLS Private Key SSM name            |
| tls_public_rsa_ssm | TLS Public Key (OpenSSH - RSA) name |
| tls_public_ssm     | TLS Public Key name                 |

## Download credentials

To download credentials via **aws-cli**, you need to have it previously downloaded and installed.

To install, go the [official tutorial](https://github.com/aws/aws-cli/tree/v2).

After **installed** and *configured*, run the command:
```sh
aws ssm get-parameter --name "/ec2/key-pair/name/private-rsa-key-pem" --output text --query Parameter.Value >> "~/my-key-pair.pem"
```

*The name is sent in the parameter to the ssm module.*

Now you have the **pem** *downloaded*.

## Author

Module written by [@victorcechinel](https://github.com/victorcechinel). 
[Linkedin](https://www.linkedin.com/in/victorcechinelr/). 
Module Support: [terraform-aws-key-pair-ssm](https://github.com/victorcechinel/terraform-aws-key-pair-ssm). 
Contributions and comments are welcomed.