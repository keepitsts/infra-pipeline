variable "profile" {
  description = "aws cli profile/keys to use"
}
variable "region" {
  default = "us-east-1"
}
variable "access_key" {
  
}
variable "secret_key" {
  
}
variable "instance_type" {
  default = "t3.micro"
}
variable "key" {
  
}

variable "security_groups" {
  type = "list"
}
variable "subnet_id" {
  
}
variable "public_ip" {
  
}

variable "role" {
  
}

variable "OSDiskSize" {
  default = "8"
}
variable "name" {
  
}