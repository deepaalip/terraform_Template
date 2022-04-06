resource "aws_security_group" "httpssh" {
    vpc_id = aws_vpc.Main.id
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "httpssh"
    }
}

resource "aws_instance" "public" {
  ami                         = "ami-0fb653ca2d3203ac1"
  associate_public_ip_address = "true"
  instance_type               = "t2.micro"
  key_name                    = "AWS-demo"
  vpc_security_group_ids      = [aws_security_group.httpssh.id]
  subnet_id                   = aws_subnet.publicsubnets.id

  tags = {
    Name = "public"
  }
}

resource "aws_instance" "private" {
  ami                         = "ami-0fb653ca2d3203ac1"
  associate_public_ip_address = "false"
  instance_type               = "t2.micro"
  key_name                    = "AWS-demo"
  vpc_security_group_ids      = [aws_security_group.httpssh.id]
  subnet_id                   = aws_subnet.privatesubnets.id

  tags = {
    Name = "private"
  }
}
