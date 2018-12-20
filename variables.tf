variable "region" {
  default = "eu-west-1"
}
variable "AmiLinux" {
  type = "map"
  default = {
    eu-west-2 = "ami-a36f8dc4"
    eu-west-1 = "ami-ca0135b3"
    us-east-1 = "ami-14c5486b"
  }
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

}
variable "credentialsfile" {
   default = "/.ssh/aws_config"
}

variable "vpc-fullcidr" {
    default = "172.16.0.0/16"
}
variable "Subnet-Public-AzA-CIDR" {
  default = "172.16.0.0/24"
}
variable "Subnet-Private-AzA-CIDR" {
  default = "172.16.3.0/24"
}
variable "key_name" {
  default = "MyAWSKey"
}
