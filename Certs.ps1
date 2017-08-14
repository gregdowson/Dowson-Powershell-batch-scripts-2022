
$threshold = 30   #Number of days to look for expiring certificates 
 
$deadline = (Get-Date).AddDays($threshold)   #Set deadline date 
 
$Servers=get-content C:\temp\servers.txt
Foreach ($server in $Servers) {
Invoke-Command -ComputerName $server { Dir Cert:\LocalMachine\My } | foreach { 
  If ($_.NotAfter -le $deadline) { $_ | Select Issuer, Subject, NotAfter, @{Label="Expires In (Days)";Expression={($_.NotAfter - (Get-Date)).Days}} } 
} }