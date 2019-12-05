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
variable "sg_name" {
  
}
variable "sg_description" {
  
}
variable "vpc_id" {
  
}
variable "http_cidr" {
  type = "list"
}
variable "ssh_cidr" {
  type = "list"
}