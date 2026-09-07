#VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
}
#Public Subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_cidr
    availability_zone = var.public_az
    map_public_ip_on_launch = true
    tags = {
        Name = var.public_subnet_name
    }
}
#Private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_cidr
    availability_zone = var.private_az
    map_public_ip_on_launch = false
    tags = {
        Name = var.private_subnet_name
    }
}
#Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = var.igw_name
    }
}
#EIP
resource "aws_eip" "eip" {
    domain = var.domain_name
    tags = {
        Name = var.eip_name
    }
}
#NAT
resource "aws_nat_gateway" "nat" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.eip.id
    tags = {
        Name = var.nat_name
    }
}
#Public route table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route{
        cidr_block = var.public_rt_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = var.public_rt_name
    }
}
#Public rt association
resource "aws_route_table_association" "public_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}
#Private route table
resource "aws_route_table" "private_rt"{
    vpc_id = aws_vpc.vpc.id
    route{
        cidr_block = var.private_rt_cidr
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = var.private_rt_name
    }
}
#Private rt association
resource "aws_route_table_association" "private_association"{
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}
#Security Group
resource "aws_security_group" "sg"{
    name = var.sg_name
    description = var.sg_name
    vpc_id = aws_vpc.vpc.id

    ingress{
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = var.ssh_protocol
        cidr_blocks = var.sg_cidr
    }

    ingress{
        from_port = var.http_port
        to_port = var.http_port
        protocol = var.http_protocol
        cidr_blocks = var.sg_cidr    
    }

    egress{
        from_port = var.egress_port
        to_port = var.egress_port
        protocol = var.egress_protocol
        cidr_blocks = var.sg_cidr
    }
}