terraform {
  backend "s3" {
    bucket  = "sts-terraform-remote-state"
    key     = "demo-pipeline"
    region  = "us-east-1"
    profile = "sts-dm"
  }
  required_version = "0.12.1"
}
module "security_group" {
  source = "./modules/security_group"
  
  profile = "sts-dm"

  sg_name = "dev_security_group"
  sg_description = "Allows access to demo resources"

  vpc_id = "vpc-0e3945d5888632944"

  http_cidr = ["0.0.0.0/0"]
  ssh_cidr = ["0.0.0.0/0"]
}

module "ec2_server" {
    source = "./modules/ec2"

    profile = "sts-dm"
    instance_type = "t3.medium"
    role = "s3_access_for_ec2"
    security_groups = ["${module.security_group.id}"]
    subnet_id = "subnet-0a1f8963d08b10d8f"
    public_ip = true
    name = "dev_server"

    key = "coffay-nova"
}
output "ip" {
  value = module.ec2_server.public_ip
}
