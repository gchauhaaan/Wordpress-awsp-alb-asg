# Wordpress-aws-alb-asg
# dbbackup.sh
Refer to https://tecadmin.net/install-s3cmd-manage-amazon-s3-buckets/ for installing s3cmd .

Use the command to make it executable : chmod +x dbbackup.sh

Schedule it with crontab
vim /etc/crontab and the following line in the file

Run the database backup script on every week at 12.00

0 0 * * 0  bash /opt/scripts/dbbackup.sh to  >/dev/null 2>&1 
