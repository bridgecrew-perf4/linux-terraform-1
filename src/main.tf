#########################################  Importing  modules #################################
module "instances"{
source = "./modules/instances"
myamiid = "${var.myamiid}"
mykeypair = "${var.mykeypair}"
}

provider "aws"{
region = "${var.myregion}"
shared_credentials_file = "/home/centos/.aws/credentials"
}

