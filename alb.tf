resource "aws_security_group" "lbsg" {
  name = "lb-secgroup"
  vpc_id = "${aws_vpc.terraformmain.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
    ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "wplb" {
  name = "web-lb"
  internal = false
  security_groups = ["${aws_security_group.lbsg.id}"]
  load_balancer_type = "application"
  subnets = ["${aws_subnet.PublicAZA.*.id}"]
  enable_deletion protection = true
}

resource "aws_lb_target_group" "targetgrp" {
  name = "alb-target-http"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.terraformmain.id}"
  health_check {
           path = "/healthcheck"
           port = "80"
           protocol = "HTTP"
           healthy_threshold = 2
           unhealthy_threshold = 2
           interval = 5
           timeout = 4
           matcher = "200-299"
        }
}

resource "aws_alb_target_group_attachment" "alb_btargetgrp_http" {
  target_group_arn = "${aws_alb_target_group.targetgrp.arn}"
  target_id        = "${aws_instance.wordpress.id}"
  port             = 80
}
