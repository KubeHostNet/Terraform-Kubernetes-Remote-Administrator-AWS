## Copyright 2020 Green River IT as described in LICENSE.txt distributed with this project on GitHub.  
## Start at https://github.com/KubeHostNet/  
  
  
import subprocess 
import os 
 
igw_id = ""
sg_id = ""
cidr_holder = ""

subprocess.run("terraform init", shell=True, check=True)

path_to_k8sadmin_iam_keys=os.environ['TF_VAR_PATH_TO_K8SADMIN_IAM_KEYS']

subprocess.run("terraform destroy -auto-approve -var-file="+path_to_k8sadmin_iam_keys+"awspublickey.tfvars -var-file="+path_to_k8sadmin_iam_keys+"awsvpcmeta.tfvars -var-file="+path_to_k8sadmin_iam_keys+"awskeymeta.tfvars -var igw_acm_host="+igw_id+" -var sgid_acm_nodes="+sg_id+" -var cidr_subnet_acm="+cidr_holder, shell=True, check=True)
