Ente#Enable script execution
set-executionpolicy unrestricted

#Add SQL Cmdlet
Add-PSSnapin SqlServerCmdletSnapin100 
Add-PSSnapin SqlServerProviderSnapin100

#Run SQLbackup monitor script with output to file
invoke-sqlcmd -inputfile "c:\scripts\sqlmonitor.sql" -serverinstance "USPETDDDBSGP002\DBADEV2014" > "c:\scripts\output.txt"

#Create event with output to System event log
$Message = get-content "c:\scripts\output.txt"
Eventcreate /ID 123 /L System /T Warning /SO BackupMonitor /D "$Message"r file contents here
