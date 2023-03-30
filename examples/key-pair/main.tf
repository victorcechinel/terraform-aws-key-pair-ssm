module "aws_rds_postgres" {
  source  = "victorcechinel/key-pair-ssm/aws"
  version = "1.0.4"

  name = "key-pair-name"

  tags = {
    Environment = "prd"
  }
}
