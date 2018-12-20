resource "aws_launch_configuration" "alc" {
  ami         = "${lookup(var.AmiLinux, var.region)}"
  instance_type    = "t2.micro"
  security_groups  = ["${aws_security_group.wordpress.id}"]
  key_name         = "${var.key_name}"
  user_data = <<-EOF
  #!/bin/bash
  sudo -i
  yum update -y
  yum install -y php httpd php-mysqlnd
  service httpd start
  chkconfig httpd on
  cd /var/www/html
  wget https://wordpress.org/latest.tar.gz
  tar xzf latest.tar.gz
  chown -R apache.apache wordpress
  service httpd restart
  EOF
  
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "asg" {
  launch_configuration = "${aws_launch_configuration.alc.id}"
  availability_zones = ["${data.aws_availability_zones.available.names}"]
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.wplb.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "terraform-asg"
    propagate_at_launch = true
  }
}
