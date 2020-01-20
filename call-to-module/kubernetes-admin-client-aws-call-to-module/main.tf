## Copyright 2020 Green River IT as described in LICENSE.txt distributed with this project on GitHub.  
## Start at https://github.com/KubeHostNet/  
    
module "kubernetes-admin-client-instance" {
  source = "../../module/kubernetes-admin-client-aws-module"

  region = "${var.region}"
  access_key = "${var.access_key}"
  internet_gateway_parent = "${var.igw_acm_host}" 
  security_group_parent = "${var.sgid_acm_nodes}" 
  subnet_id_parent = "${var.cidr_subnet_acm}" 
  path_to_ssh_keys = "${var.path_to_ssh_keys}" 
  name_of_ssh_key = "${var.name_of_ssh_key}" 

}

variable "region" { }
variable "access_key" { }
variable "igw_acm_host" { }
variable "sgid_acm_nodes" { }
variable "cidr_subnet_acm" { }
variable "path_to_ssh_keys" { }
variable "name_of_ssh_key" { }
