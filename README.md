# Wordpress-aws-alb-asg
# dbbackup.sh
Refer to https://tecadmin.net/install-s3cmd-manage-amazon-s3-buckets/ for installing s3cmd .

Use the command to make it executable : chmod +x dbbackup.sh

Schedule it with crontab
vim /etc/crontab and the following line in the file

Run the database backup script on every day twice at 11 Am and 4Pm

0 11,16 * * *  /bin/bash /opt/scripts/dbbackup.sh > /dev/null 2>&1 
