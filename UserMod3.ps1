$date = ((get-date).addmonths(-24))
Get-ADUser -Filter * -Properties whenChanged| Where-Object {$_.whenChanged -gt $date} | select name, whenChanged |Export-Csv -Path "mod5.csv" -NoTypeInformation
