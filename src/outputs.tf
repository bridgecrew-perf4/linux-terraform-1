output "webserver_public_ip"{
value = "${module.instances.webserver_publicip}"
}
output "webserver_private_ip"{
value = "${module.instances.webserver_privateip}"
}
output "appserver_public_ip"{
value = "${module.instances.appserver_publicip}"
}
output "dbbserver_public_ip"{
value = "${module.instances.dbserver_publicip}"
}
