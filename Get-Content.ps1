$YourFile = Get-Content 'C:\scripts\computers.txt'

foreach ($computer in $YourFile)
{

Restart-Computer -ComputerName $computer -force