# Terraform Kubernetes Remote Administrator AWS  
  
Terraform Kubernetes Remote Administrator AWS is an open-source toolkit for administering 
Kubernetes clusters created by KubeHostNet.  This project is a component of KubeHostNet,  
which will consume this.  
  
Terraform Kubernetes Remote Administrator AWS is comprised of a Terraform module and of 
a call to that Terraform module.  KubeHostNet will use this module and call to 
create administration machines inside KubeHostNet's central VPC.  The reason that 
this is separated into a distinct module is so that KubeHostNet can create a 
separate administration machine for each and every Kubernetes cluster that will be created and 
managed by KubeHostNet as part of the work of creating and managing dynamic 
cloud systems.  
  
The primary development of Terraform Kubernetes Remote Administrator AWS was done by
[Green River IT, Incorporated](http://greenriverit.com) in California.  It is released 
under the generous license terms defined in the [LICENSE](LICENSE.txt) file.  
  
## Support  
  
If you encounter any problems with this release, please create a 
[GitHub Issue](https://github.com/GreenRiverIT/Terraform-Kubernetes-Remote-Administrator-AWS/issues).
  
For commercial support please send us an email.  
    
## Dependencies  
  
This project is meant to be consumed by KubeHostNet.  
  