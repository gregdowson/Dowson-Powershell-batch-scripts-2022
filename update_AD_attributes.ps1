# Import AD Module             
Import-Module ActiveDirectory            
            
# Import CSV into variable $userscsv            
#$userscsv = import-csv C:\users\gdadmin\scripts\adusertest.csv            
$users = Import-Csv -Path C:\users\gdadmin\scripts\adusertest.csv           
# Loop through CSV and update users if the exist in CVS file            
            
foreach ($user in $users) {            
#Search in specified OU and Update existing attributes            
Get-ADUser -Filter "SamAccountName -eq '$($user.samaccountname)'" -Properties * -SearchBase "CN=Users,DC=NMI,DC=local" | Set-ADUser -Replace @{Manager = "$($user.Manager)"}}