$computers= get-content "C:\scripts\CitrixServers.txt"

foreach($computer in $computers)
{
 Get-EventLog -ComputerName $computer -LogName System -EntryType "Error" -After (Get-Date).Adddays(-2) -verbose}