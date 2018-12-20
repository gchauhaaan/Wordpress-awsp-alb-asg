resource "aws_instance" "wordpress" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "My wordpress App"
  }
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
 }
  
  
  resource "aws_instance" "database" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "false"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.MySQLDB.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "sql database"
  }
  user_data = <<-EOF
  #!/bin/bash
  sleep 180
  yum update -y
  yum install -y mysql55-server
  service mysqld start
  /usr/bin/mysqladmin -u root password 'admin'
  mysql -u root -p admin -e "create user 'root'@'%' identified by 'admin';" mysql
  EOF
 }
