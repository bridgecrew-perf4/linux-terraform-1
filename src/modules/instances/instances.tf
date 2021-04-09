provider "template"{

}


data "template_file" "webserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
  vars = {
   vm_role = "web"
  }
}



################################################  web server #########################
resource "aws_instance" "webserver" {
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${aws_subnet.publicsubnet.id}"
private_ip = "192.168.1.6"
vpc_security_group_ids = ["${aws_security_group.websg.id}"]
key_name = "${var.mykeypair}"
user_data = "${data.template_file.webserver-userdata.rendered}"
tags = {
Name = "webserver"
}
}


############################################ Networking modules ######################
resource "aws_eip" "webeip"{
instance = "${aws_instance.webserver.id}"
}

resource "aws_vpc" "myvpc"{
cidr_block = "192.168.0.0/16"
tags ={
Name = "myvpc"
}
}

resource "aws_internet_gateway" "myigw"{
vpc_id = "${aws_vpc.myvpc.id}"
tags={
Name = "myigw"
}
}


resource "aws_subnet" "publicsubnet"{
vpc_id = "${aws_vpc.myvpc.id}"
cidr_block = "192.168.1.0/24"
tags={
Name = "publicsubnet"
}
}

resource "aws_route_table" "publicrtb"{
vpc_id = "${aws_vpc.myvpc.id}"
tags = {
Name = "publicrtb"
}
}

resource "aws_route" "publicrt"{
route_table_id = "${aws_route_table.publicrtb.id}"
destination_cidr_block = "0.0.0.0/0"
gateway_id = "${aws_internet_gateway.myigw.id}"
}
 
resource "aws_route_table_association" "publicrtba"{
route_table_id = "${aws_route_table.publicrtb.id}"
subnet_id = "${aws_subnet.publicsubnet.id}"
}

##############################################  Security Modules ########################

resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow all traffic"
  vpc_id ="${aws_vpc.myvpc.id}"
  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "websg"
  }
}

