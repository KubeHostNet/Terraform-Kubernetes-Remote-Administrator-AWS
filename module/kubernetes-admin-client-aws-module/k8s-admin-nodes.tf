## Copyright 2020 Green River IT as described in LICENSE.txt distributed with this project on GitHub.  
## Start at https://github.com/KubeHostNet/  
      
####################################################  
# Below we create the USERDATA to get the instance ready to run the Kubernetes admin client.
# The Terraform local simplifies Base64 encoding.  
locals {

  kubernetes-admin-userdata = <<USERDATA
#!/bin/bash -xe
su - 
### Install software
sudo yum -y update
sudo amazon-linux-extras install -y epel
sudo yum -y install awscli
sudo yum -y install telnet
### Create user for the Kubernetes administrator client
sudo groupadd -g 2002 kubernetes-host
sudo useradd -u 2002 -g 2002 -c "Kubernetes Admin Account" -s /bin/bash -m -d /home/kubernetes-host kubernetes-host
# Configure SSH for the user
mkdir -p /home/kubernetes-host/.ssh
cp -pr /home/ec2-user/.ssh/authorized_keys /home/kubernetes-host/.ssh/authorized_keys
#cp /home/ec2-user/.ssh/kubernetes-host.pem /home/kubernetes-host/.ssh/kubernetes-host.pem
chown -R kubernetes-host:kubernetes-host /home/kubernetes-host/.ssh
chmod 700 /home/kubernetes-host/.ssh
# Add user to sudoers with no password, ssh-only authentication
cat << 'EOF' > /etc/sudoers.d/kubernetes-host
User_Alias KUBERNETES_HOST = %kubernetes-host
KUBERNETES_HOST ALL=(ALL)      NOPASSWD: ALL
EOF
chmod 400 /etc/sudoers.d/kubernetes-host
cat << 'EOF' >> /etc/ssh/sshd_config
Match User kubernetes-host
        PasswordAuthentication no
        AuthenticationMethods publickey

EOF
# restart sshd
systemctl restart sshd
# Make the .pem file only readable by the kubernetes-host user.  This will avoid a security roadblock and enable its use.
#chmod 400 /home/kubernetes-host/.ssh/kubernetes-host.pem
# Make the directory for the kube config file to go
mkdir -p /home/kubernetes-host/.kube
chown -R kubernetes-host:kubernetes-host /home/kubernetes-host/.kube
# Remove comment from next line to improve security after we establish that it works without security.
#chmod 700 /home/kubernetes-host/.kube
USERDATA

}

data "aws_ami" "amazon-linux-2" {  
  most_recent = true
  
  owners = ["amazon"]
 
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  
  filter {
    name   = "architecture"
    values = ["x86_64*"]
  }

}  

resource "aws_instance" "kubernetes-host" {  
  ami                         = "${data.aws_ami.amazon-linux-2.id}"
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.kubernetes-admin.id}"
  instance_type               = "t2.micro"
  key_name                    = "${var.name_of_ssh_key}"
  user_data_base64 = "${base64encode(local.kubernetes-admin-userdata)}"
  source_dest_check           = false
  vpc_security_group_ids      = ["${var.security_group_parent}"]
  subnet_id                   = "${var.subnet_id_parent}"

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
  
  tags = { Name = "k8sadmin" }
}
