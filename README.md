Project Title
=====================
Terraform is used to provision and manage IT Infrastructure


Execution Flow
=====================

$git clone https://github.com/cloudstones/linux-terraform.git

$cd linux-terraform/src

$terraform init .

$terraform validate -var-file=config.json .

$terraform apply -var-file=config.json .
