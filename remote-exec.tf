provider "aws" {
  region     = "us-west-2"
  access_key = "<access-key>"
  secret_key = "<secret-key>"
}

resource "aws_instance" "web" {
  ami           = "ami-082b5a644766e0e6f"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./terraform-key.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
     "sudo amazon-linux-extras install -y nginx1",
     "sudo systemctl start nginx"
    ]
  }
}
