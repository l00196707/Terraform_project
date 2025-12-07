resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    description = "Allow HTTP from internet to ALB"
    vpc_id = aws_vpc.project_vpc.id

    ingress {
        description = "HTTP from internet"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "alb-sg"
        Owner = var.owner
    }
}


resource "aws_lb" "web_alb" {
    name = "project-alb"
    load_balancer_type = "application"
    internal = false

    subnets = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
    ]

    security_groups = [aws_security_group.alb_sg.id]

    tags = {
        Name = "project-alb"
        Owner = var.owner
    }
}

resource "aws_lb_target_group" "web_tg" {
    name = "web-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.project_vpc.id

    health_check {
        path = "/"
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

    tags = {
        Name = "web-tg"
        Owner = var.owner
    }
}

resource "aws_lb_target_group_attachment" "web1" {
    target_group_arn = aws_lb_target_group.web_tg.arn
    target_id = aws_instance.web_1.id
    port = 80
}

resource "aws_lb_target_group_attachment" "web2" {
    target_group_arn = aws_lb_target_group.web_tg.arn
    target_id = aws_instance.web_2.id
    port = 80
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.web_alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.web_tg.arn
    }
}