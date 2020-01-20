## Copyright 2020 Green River IT as described in LICENSE.txt distributed with this project on GitHub.  
## Start at https://github.com/KubeHostNet/  
    
# Using these data sources allows the configuration to be generic for any region.
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

variable "access_key" { }
variable "region" { }
variable "path_to_ssh_keys" { }
variable "name_of_ssh_key" { }
variable "internet_gateway_parent" { }
variable "security_group_parent" { }
variable "subnet_id_parent" { }

#############Output variables
output "private_ip_admin_k8s" { value = "${aws_instance.kubernetes-host.private_ip}" }
