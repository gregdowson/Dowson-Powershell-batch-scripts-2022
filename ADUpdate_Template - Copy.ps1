$users = Get-Content "C:\list.txt"          
            
foreach ($user in $users) {            
Set-ADUser -Identity $user -Replace @{Manager = "CN=Jsmith,OU=IT,OU=AllUsers,DC=mydomain,DC=local"
}}