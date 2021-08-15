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

resource "aws_instance" "irssi_dev" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t4g.nano"
  cpu_core_count         = "1"
  cpu_threads_per_core   = "1"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.irssi_dev.id]
  user_data              = templatefile("${path.module}/cloudinit.yml", { irc_username = var.irc_username, gh_username = var.gh_username, irssi_gist = var.irssi_gist })
  root_block_device { 
    volume_type = "standard"
    volume_size = 8
  }
    
  tags = {
    Name = "irssi-dev"
  }
}
