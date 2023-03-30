resource "tls_private_key" "tls_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key" {
  name        = format("/ec2/key-pair/%s/private-rsa-key-pem", var.name)
  description = "TLS Private Key"
  type        = "String"
  value       = tls_private_key.tls_key_pair.private_key_pem
  overwrite   = true

  tags = var.tags

  depends_on = [
    tls_private_key.tls_key_pair
  ]
}

resource "aws_ssm_parameter" "ssm_key_pair_private_key_rsa" {
  name        = format("/ec2/key-pair/%s/public-rsa-key-pem", var.name)
  description = "TLS Public Key (OpenSSH - RSA)"
  type        = "String"
  value       = tls_private_key.tls_key_pair.public_key_pem
  overwrite   = true

  tags = var.tags

  depends_on = [
    tls_private_key.tls_key_pair
  ]
}

resource "aws_ssm_parameter" "ssm_key_pair_public_key" {
  name        = format("/ec2/key-pair/%s/public-rsa-key-openssh", var.name)
  description = "TLS Public Key"
  type        = "String"
  value       = tls_private_key.tls_key_pair.public_key_openssh
  overwrite   = true

  tags = var.tags

  depends_on = [
    tls_private_key.tls_key_pair
  ]
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.name
  public_key = tls_private_key.tls_key_pair.public_key_openssh

  tags = var.tags

  depends_on = [
    tls_private_key.tls_key_pair
  ]
}
