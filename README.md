<strong>Terraform</strong>

Terraform is an open-source, infrastructure as code, software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

See https://www.terraform.io/downloads

Install Terraform

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

See https://registry.terraform.io/browse/providers

Commands

```
terraform init
terraform plan
terraform apply
```

```
terraform destroy
terraform destroy -target aws_instance.web
```

```
terraform refresh
```

Terraform Cloud: https://cloud.hashicorp.com/products/terraform
