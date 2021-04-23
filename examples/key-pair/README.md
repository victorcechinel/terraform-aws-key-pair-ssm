# Example Create Key Pair

Execute ssh commands:
```sh
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

## Inputs

| Name | Description   | Type   | Default | Required |
| ---- | ------------- | ------ | ------- | -------- |
| name | Key Pair name | string | -       | yes      |
| tags | Tags          | array  | -       | no       |

## Settings

If you configure shared_credentials_file in the providers.tf file,
it is not necessary to configure the profile in the terraform.tf file.