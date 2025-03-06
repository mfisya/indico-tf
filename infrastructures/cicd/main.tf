resource "aws_security_group" "ec2_sg" {
    name        = "ec2_sg"
    description = "Security group for EC2 instance"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_configuration" "ec2_lc" {
    name          = "ec2_lc"
    image_id      = "ami-0c94855ba95c71c99"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.ec2_sg.id]
}

resource "aws_autoscaling_group" "ec2_asg" {
    name                      = "ec2_asg"
    launch_configuration      = aws_launch_configuration.ec2_lc.name
    min_size                  = 1
    max_size                  = 3
    desired_capacity          = 1
    vpc_zone_identifier       = [var.vpc_id]
    health_check_type         = "EC2"
    health_check_grace_period = 300
}

resource "aws_instance" "ec2_instance" {
    count         = aws_autoscaling_group.ec2_asg.desired_capacity
    instance_type = "t2.micro"
    security_groups = [aws_security_group.ec2_sg.id]
    key_name      = "your_key_pair_name"
    ami           = "ami-0c94855ba95c71c99"

    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y git",
            "mkdir -p ~/bitbucket-runner && cd ~/bitbucket-runner",
            "curl -L https://product-downloads.atlassian.com/software/bitbucket/pipelines/runner/1.459/bitbucket-pipelines-runner-linux-amd64 -o bitbucket-runner",
            "chmod +x bitbucket-runner",
            "./bitbucket-runner setup --url <BITBUCKET_URL> --token <TOKEN>"
        ]
    }
}