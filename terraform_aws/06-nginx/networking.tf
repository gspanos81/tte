#!: locals are used like variables but they are defined and used only within the module they are defined in
locals {
  common_tags = {
    ManagedBy = "main_vpc"
    Project   = "06_resources_tags"
    Gespanos  = "Terraform"
    Name      = "06_resources"
  }
}
#2: merge function is used to combine two maps into one
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.common_tags, {
    Name2 = "main_vpc"
  })

}
#3: to use the tags defined in locals we use tags = local.common_tags
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags       = local.common_tags
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags

}
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main.id
  tags   = local.common_tags

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main_rt.id
}
# resource "aws_subnet" "private" {
#     vpc_id     = aws_vpc.main.id
#     cidr_block = "

# }

#TODO: #add comments to this file 