#Public Instance
resource "aws_instance" "public_ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnet_id
    vpc_security_group_ids = [var.sg_id]
    user_data = file("/root/tfvars/module/ec2/user_data.sh")
    tags = {
        Name = var.public_instance_name
    }
}
#Private instance
resource "aws_instance" "private_ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.private_subnet_id
    vpc_security_group_ids = [var.sg_id]
    user_data = file("/root/tfvars/module/ec2/user_data.sh")
    tags = {
        Name = var.private_instance_name
    }

}