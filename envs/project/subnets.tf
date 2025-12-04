resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.aws_region}a"
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.aws_region}b"
    map_public_ip_on_launch - true
     
    tags = {
        Name = "public-subnet-2"
    }
}

resourse "aws_subnet" "private_1" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "${var.aws_region}a"
    
    tags = {
        Name = "private-subnet-1"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.project_vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "${var.aws_region}b"
    
    tags = {
        Name = "private-subnet-2"
    }
}