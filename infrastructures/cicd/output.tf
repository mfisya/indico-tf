output "ec2_instance_ids" {
    value = aws_instance.example[*].id
}