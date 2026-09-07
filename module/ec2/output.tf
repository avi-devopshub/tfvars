output "public_ip" {
    value = aws_instance.public_ec2.public_ip
}
output "public_ec2_arn" {
    value = aws_instance.public_ec2.arn
}
output "public_ec2_id" {
    value = aws_instance.public_ec2.id
}
output "public_ec2_private_ip" {
    value = aws_instance.public_ec2.private_ip
}
output "private_ip" {
    value = aws_instance.private_ec2.private_ip
}
output "private_ec2_id" {
    value = aws_instance.private_ec2.id
}
output "private_ec2_arn" {
    value = aws_instance.private_ec2.arn
}
