data "aws_subnet" "subnet_private_b" {
  id = var.subnet_private_b
}
#application load balancer
resource "aws_lb" "private-alb" {
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_clb.id]
  subnets            = [data.aws_subnet.subnet_public_a.id, data.aws_subnet.subnet_public_b.id]
  
  enable_deletion_protection = false

}

resource "aws_alb_target_group" "alb_target_private" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "alb-target-backend"
  port        = 3000  
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.lab_vpc.id
}

resource "aws_alb_listener" "alb_listener_internal" {
  load_balancer_arn = aws_lb.private-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_private.arn
    type = "forward"

  }
}
resource "aws_lb_target_group_attachment" "ec2_backend_attach" {
  target_group_arn = aws_alb_target_group.alb_target_private.arn
  target_id = aws_instance.ec2_backend.id
}
#classic load balancer internal
#resource "aws_elb" "loadbalancer_internal" {
#  name               = "loadbalancerinternal"
#
#  subnets = [data.aws_subnet.subnet_private.id]
#  security_groups = [aws_security_group.sg_clb.id]
#  internal =  true
#  listener {
#    instance_port     = 3000
#    instance_protocol = "http"
#    lb_port           = 3030
#    lb_protocol       = "http"
#  }
#  health_check {
#    healthy_threshold   = 2
#    unhealthy_threshold = 2
#    timeout             = 3
#    target              = "HTTP:3000/"
#    interval            = 30
#  }
#instances= [aws_instance.ec2_backend.id]
#}