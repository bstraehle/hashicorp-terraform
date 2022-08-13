<strong>HashiCorp Terraform</strong>

Terraform is an open-source, infrastructure as code, software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

See https://www.terraform.io/downloads and https://registry.terraform.io

Install on Amazon Linux:

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
```

Terraform Cloud: https://cloud.hashicorp.com/products/terraform

Commands:

```
terraform init
terraform plan
terraform apply

terraform destroy
```

```
terraform graph > graph.dot

sudo yum install graphviz

cat graph.dot | dot -Tsvg > graph.svg
```

Resources:

- https://learn.hashicorp.com/tutorials/terraform/eks
- https://learn.hashicorp.com/tutorials/terraform/aks
- https://learn.hashicorp.com/tutorials/terraform/gke
- https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider
