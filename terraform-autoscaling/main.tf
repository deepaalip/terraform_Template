provider "aws" { profile = "default" }

resource "aws_launch_template" "autoscaling" {
  name_prefix   = "autoscaling"
  image_id      = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-2b"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
   

  launch_template {
    id      = aws_launch_template.autoscaling.id
    version = "$Latest"
  }
}
