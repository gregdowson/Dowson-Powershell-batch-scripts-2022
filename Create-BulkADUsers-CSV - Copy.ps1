Import-Module ActiveDirectory
Import-Csv "C:\Scripts\NewUsers.csv" | ForEach-Object {
 $userPrincinpal = $_."samAccountName" + "@extnmi.local"
New-ADUser -Name $_.Name `
 -Path $_."ParentOU" `
 -SamAccountName  $_."samAccountName" `
 -UserPrincipalName  $userPrincinpal `
 -AccountPassword (ConvertTo-SecureString "MyPassword123" -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true
Add-ADGroupMember "Domain Users" $_."samAccountName";
}