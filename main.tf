provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "web" {
  ami           = "${var.ami-image}"
  instance_type = "t2.micro"

  tags = {
    Name = "packer-php-aws"
  }
  key_name = "aws-key"

  provisioner "file" {
    source      = "files-to-deploy.zip"
    destination = "/tmp/files-to-deploy.zip"
    connection {
      host        = "${aws_instance.web.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("${var.ssh-key}")}"
    }
  }
  provisioner "remote-exec" {
    script = "deploy_website.sh"

    connection {
      host        = "${aws_instance.web.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("${var.ssh-key}")}"
    }
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}