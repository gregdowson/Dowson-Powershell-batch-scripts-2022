
# Add a domin admin to extnmi
# Paul Johnson to have a delegated admin account in CI, Stag, and Prod. 
Try 
{ 
  Import-Module ActiveDirectory -ErrorAction Stop 
} 
Catch 
{ 
  Write-Host "[ERROR]`t ActiveDirectory Module couldn't be loaded. Script will stop!" 
  Exit 1 
} 
$FN = Read-host "Type Users Full Name"
$CR = Read-host "Type CR Number"
$Sam = Read-host "Type Sam Account Name"


$Desc = "$FN Admin Account $CR"
$Pwd = "Tree-View2017" | ConvertTo-SecureString -AsPlainText -Force

$dnsroot = '@' + (Get-ADDomain).dnsroot
$Man = "garet.jones"
$DC = (Get-ADDomain).dnsroot
	$DC = $DC.split(".")
	$DC1= $DC[0]
	$DC2= $DC[1]
	$DC3= $DC[2]
IF ($DC3 -eq $NULL){$Path = "OU=DelegatedAdmins,OU=DomainAdmins,DC=$DC1,DC=$DC2" }
IF ($DC3){$Path = "OU=DelegatedAdmins,OU=DomainAdmins,DC=$DC1,DC=$DC2,DC=$DC3" }
$Path

	New-ADUser $Sam -samaccountname $sam -AccountPassword $Pwd -Path $Path
	Set-ADUser $Sam -Description $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot) -PassThru | Enable-ADAccount
	
	$Members = "CN=$sam,$Path"
	Get-ADGroup "HelpdeskAdmins" | Add-ADGroupMember -Members $Members
	Get-ADgroup "ITShareFullAccess" | Add-ADGroupMember -Members $Members
	
	$Man = "garet.jones"
	$Sam = "pjadmin"
	Set-ADUser $Sam -Description $Desc -manager $Man -title $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot)

# Verify account creation
Get-aduser $Sam -properties Manager, Description, title, UserPrincipalName
Get-ADPrincipalGroupMembership $Sam | select name

