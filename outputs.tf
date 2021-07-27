output "key_pair_name" {
  value       = aws_key_pair.key_pair.key_name
  description = "Key pair name."
}

output "tls_private_ssm" {
  value       = aws_ssm_parameter.ssm_key_pair_private_key.name
  description = "Private key."
}

output "tls_public_rsa_ssm" {
  value       = aws_ssm_parameter.ssm_key_pair_private_key_rsa.name
  description = "Private key RSA."
}

output "tls_public_ssm" {
  value       = aws_ssm_parameter.ssm_key_pair_public_key.name
  description = "Public key."
}
