output "webserver_publicip" {
value = "${aws_eip.webeip.public_ip}"
}
output "webserver_privateip" {
value = "${aws_instance.webserver.private_ip}"
}
output "appserver_publicip" {
value = "${aws_eip.appeip.public_ip}"
}
output "dbserver_publicip" {
value = "${aws_eip.dbeip.public_ip}"
}
