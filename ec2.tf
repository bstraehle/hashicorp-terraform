provider "aws" {
  region     = "us-west-2"
  access_key = "<access-key>"
  secret_key = "<secret-key>"
}

resource "aws_instance" "web" {
  ami           = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
}
