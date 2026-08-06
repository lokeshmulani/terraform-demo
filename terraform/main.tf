provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-02b64aa047cb5edf5"
  instance_type = "c7a.large"
  key_name      = "azlin"

  tags = {
    Name = "Terraform-WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              EOF
}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}
