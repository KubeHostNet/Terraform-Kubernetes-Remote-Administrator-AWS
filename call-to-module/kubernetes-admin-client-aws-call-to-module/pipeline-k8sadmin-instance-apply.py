## Copyright 2020 Green River IT as described in LICENSE.txt distributed with this project on GitHub.  
## Start at https://github.com/KubeHostNet/  
    
import subprocess
import sys
import os 


try: 
    path_to_k8sadmin_iam_keys=os.environ['TF_VAR_PATH_TO_K8SADMIN_IAM_KEYS']
    print("path_to_k8sadmin_iam_keys is: "+path_to_k8sadmin_iam_keys)
    igw_id=sys.argv[2]
    print("igw_id is: "+igw_id)
    sg_id=sys.argv[3]
    print("sg_id is: "+sg_id)
    cidr_holder=sys.argv[4]
    print("cidr_holder is: "+cidr_holder)

    subprocess.run("terraform init", shell=True, check=True)

    applyCommand="terraform apply -auto-approve -var-file="+path_to_k8sadmin_iam_keys+"awspublickey.tfvars -var-file="+path_to_k8sadmin_iam_keys+"awsvpcmeta.tfvars -var-file="+path_to_k8sadmin_iam_keys+"awskeymeta.tfvars -var igw_acm_host="+igw_id+" -var sgid_acm_nodes="+sg_id+" -var cidr_subnet_acm="+cidr_holder

    print("applyCommand is: " +applyCommand)

    subprocess.run(applyCommand, shell=True, check=True)
except Exception as e:
    print("stdout output:\n", e.output)
    sys.exit()
