data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "name" {
  
  tags = {
    Env = "Prod"
  }
}

resource "aws_instance" "web" {
 # ami                         = "ami-0e42de9d667b232f7"
 # ami = "ami-0a8461f96488011c8" 
   ami                         = data.aws_ami.ubuntu.id

  instance_type               = "t3.micro"
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
lifecycle {
    create_before_destroy = true
  }

}

output "valid" {
  value = data.aws_ami.ubuntu.id
}

output "vpc_id" {
  value = data.aws_vpc.name.id
  
}
