data "aws_subnet" "subnet_public_b" {
  id = var.subnet_public_b
}

#application load balancer
resource "aws_lb" "public-alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_clb.id]
  subnets            = [data.aws_subnet.subnet_public_a.id, data.aws_subnet.subnet_public_b.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb"
  }
}

resource "aws_alb_target_group" "alb_target" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "alb-target"
  port        = 3030  
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.lab_vpc.id
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.public-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target.arn
    type = "forward"

  }
}
resource "aws_lb_target_group_attachment" "ec2_frontend_attach" {
  target_group_arn = aws_alb_target_group.alb_target.arn
  target_id = aws_instance.ec2_frontend.id
}

#classic load balancer
#resource "aws_elb" "loadbalancer" {
#  name               = "loadbalancerexternal"
#
#  subnets = [data.aws_subnet.subnet_public.id]
#  security_groups = [aws_security_group.sg_clb.id]
#  internal =  false
#  listener {
#    instance_port     = 3030
#    instance_protocol = "http"
#    lb_port           = 80
#    lb_protocol       = "http"
#  }
#  health_check {
#    healthy_threshold   = 2
#    unhealthy_threshold = 2
#    timeout             = 3
#    target              = "HTTP:3030/"
#    interval            = 30
#  }
#instances= [aws_instance.ec2_frontend.id]
#}