resource "aws_instance" "web_1" {
    ami = "ami-0fa3fe0fa7920f68e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_1.id
    security_groups = [aws_security_group.web_sg.id]

    user_data = <<-EOF
        #!/bin/bash
        sudo dnf install -y nginx
        systemctl enable nginx
        systemctl start nginx
    EOF

    tags = {
        Name = "web-1"
    }
}

resource "aws_instance" "web_2" {
    ami = "ami-0fa3fe0fa7920f68e"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_1.id
    security_groups = [aws_security_group.web_sg.id]

    user_data = <<-EOF
        #!/bin/bash
        sudo dnf install -y nginx
        systemctl enable nginx
        systemctl start nginx
    EOF

    tags = {
        Name = "web-2"
    }
}