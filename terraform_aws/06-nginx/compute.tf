resource "aws_instance" "web" {
 # ami                         = "ami-0e42de9d667b232f7"
  ami = "ami-0a8461f96488011c8" 
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.http_sg.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
lifecycle {
    create_before_destroy = true
  }

}


resource "aws_security_group" "http_sg" {
  name        = "http_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

}
resource "aws_vpc_security_group_ingress_rule" "http_inbound" {
  security_group_id = aws_security_group.http_sg.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "https_inbound" {
  security_group_id = aws_security_group.http_sg.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}


