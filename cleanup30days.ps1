$Path = "c:\inetpub\logs\LogFiles"
$Daysback = "-30"
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
