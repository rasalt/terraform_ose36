variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-563ca440"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "admin-key.pub"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "admin-key"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
} 
