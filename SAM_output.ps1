# Import AD Module             
Import-Module ActiveDirectory            
            
# Import CSV into variable $userscsv            
#$userscsv = import-csv C:\users\gdadmin\scripts\adusertest.csv            
$users = Import-Csv -Path C:\users\gdadmin\scripts\adusertest.csv           
# Loop through CSV and update users if the exist in CVS file            
            
foreach ($user in $users) {            
            
 Get-ADUser -Identity $user.SamAccountName -Properties * |            
 select SamAccountName }            