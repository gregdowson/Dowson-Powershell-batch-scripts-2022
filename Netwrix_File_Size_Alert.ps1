if((Get-Item "\\VMI-SQLENT-01\D$\MSSQL\MSSQL13.MSSQLSERVER\MSSQL\*.*").length -gt 100GB) {
       Send-MailMessage -from sysadmin@usfca.edu -To sysadmin@usfca.edu -subject "File size has exceeded 100 GB" -Body "$filesize has exceeded 100GB" -SmtpServer smtp.usfca.edu}
