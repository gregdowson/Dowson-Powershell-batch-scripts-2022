$Date = [datetime]”3/19/2016"
Get-ADObject -Filter 'whenChanged -gt $Date' -Properties *| 
select Name, sAMAccountName, whenChanged, whenCreated | Format-Table -AutoSize 
