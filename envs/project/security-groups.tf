resource "aws_security_group" "web_sg" {
    name = "web-sg"
    vpc_id = aws_vpc.project_vpc.id
    description = "Allow HTTP, SSH from admin IP"

    ingress {
        description = "Allow SSH from admin IP"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.admin_ip]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}