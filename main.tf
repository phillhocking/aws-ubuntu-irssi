provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-20210429"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "deploy" {
  template = file("cloudinit.yml")

}

resource "aws_instance" "irssi_dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t4g.nano"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.irssi_dev.id]
  user_data              = data.template_file.deploy.rendered
  tags = {
    Name = "irssi-dev"
  }
}
