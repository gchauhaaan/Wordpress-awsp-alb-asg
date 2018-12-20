provider "aws" {
  shared_credentials_file = "${var.credentialsfile}"
  region     = "${var.region}"
}
resource "aws_vpc" "terraformmain" {
    cidr_block = "${var.vpc-fullcidr}"
    enable_dns_support = true
    tags {
      Name = "My terraform vpc"
    }
}
