$UserName = Get-Content "c:\scripts\users.txt"  
  
foreach ($User in $UserName) {Set-ADAccountExpiration $User -DateTime "4/11/2011"}