Project Title
=====================
Terraform is used to provision and manage IT Infrastructure

Pre-Requisites
============================
$ sh hardening.sh reference: https://github.com/krishnamaram2/webapp


Execution Flow
=====================

step 0: create the below objects in AWS

create s3 bucket

create file under above s3 bucket

create DynamoDB table

step 1: clone repo

$git clone https://github.com/krishnamaram2/infrastructure-manager.git


Step 2: move to directory

cd infrastructure-manager/src



Step 3: enter access key and secret key in the below files 

$vi backend.tf

terraform{

backend "s3"{

access_key = ""

secret_key = ""

region = "us-east-1"

bucket = "<mybucket>"

key = "<myfile>"

dynamodb_table = "<mytable>"

}

}


$vi config.json

{

"myregion" : "us-east-1",

"myaccesskey" : "",

"mysecretkey" : "",

"myamiid" : ""

}


Step 4:

$terraform init .

$terraform validate -var-file=config.json .

$terraform apply -var-file=config.json .
