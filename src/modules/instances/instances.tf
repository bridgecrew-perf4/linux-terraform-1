provider "template"{

}


data "template_file" "webserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
  vars = {
   vm_role = "web"
  }
}



################################################  lb server #########################
resource "aws_instance" "lbserver" {
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${aws_subnet.publicsubnet1.id}"
private_ip = "192.168.1.6"
vpc_security_group_ids = ["${aws_security_group.websg.id}"]
key_name = "${var.mykeypair}"
user_data = "${data.template_file.webserver-userdata.rendered}"
tags = {
Name = "lbserver"
}
}

################################################  app server #########################
resource "aws_instance" "appserver" {
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${aws_subnet.publicsubnet1.id}"
private_ip = "192.168.1.7"
vpc_security_group_ids = ["${aws_security_group.websg.id}"]
key_name = "${var.mykeypair}"
user_data = "${data.template_file.webserver-userdata.rendered}"
tags = {
Name = "appserver"
}
}
