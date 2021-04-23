provider "aws" {
  region = "sa-east-1"
}

resource "tls_private_key" "tls_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key" {
  name        = "/ec2/key-pair/${var.name}/private-rsa-key-pem"
  description = "TLS Private Key"
  type        = "String"
  value       = tls_private_key.tls_key_pair.private_key_pem
  overwrite   = true
  depends_on  = [tls_private_key.tls_key_pair]

  tags = var.tags
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key_rsa" {
  name        = "/ec2/key-pair/${var.name}/public-rsa-key-pem"
  description = "TLS Public Key (OpenSSH - RSA)"
  type        = "String"
  value       = tls_private_key.tls_key_pair.public_key_pem
  overwrite   = true
  depends_on  = [tls_private_key.tls_key_pair]

  tags = var.tags
}

resource "aws_ssm_parameter" "ssm_key_pair_public_key" {
  name        = "/ec2/key-pair/${var.name}/public-rsa-key-openssh"
  description = "TLS Public Key"
  type        = "String"
  value       = tls_private_key.tls_key_pair.public_key_openssh
  overwrite   = true
  depends_on  = [tls_private_key.tls_key_pair]

  tags = var.tags
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.name
  public_key = tls_private_key.tls_key_pair.public_key_openssh
  depends_on = [tls_private_key.tls_key_pair]

  tags = var.tags
}
