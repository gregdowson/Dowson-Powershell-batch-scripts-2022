
# Add a domin admin to extnmi
# Thomas Smith to have a domain admin account in CI, Stag, and Prod. 
Try 
{ 
  Import-Module ActiveDirectory -ErrorAction Stop 
} 
Catch 
{ 
  Write-Host "[ERROR]`t ActiveDirectory Module couldn't be loaded. Script will stop!" 
  Exit 1 
}
 
$CR = Read-Host "New Admin users CR Number; CR1234567"
$Sam = Read-Host "New Admin samAccountName; mfadmin"
$FullName = Read-Host "New users Full Name; Michael Felkins"
$Name = $FullName.split(" ")
$FName = $Name[0]
$LName = $Name[1]

$Desc = "$FullName Admin Account $CR"
$Pwd = "Tree-View2017" | ConvertTo-SecureString -AsPlainText -Force
$dnsroot = '@' + (Get-ADDomain).dnsroot
$Man = "bob.vail"
$DC = (Get-ADDomain).dnsroot
	$DC = $DC.split(".")
	$DC1= $DC[0]
	$DC2= $DC[1]
	$DC3= $DC[2]
IF ($DC3 -eq $NULL){$Path = "OU=DomainAdmins,DC=$DC1,DC=$DC2" }
IF ($DC3){$Path = "OU=DomainAdmins,DC=$DC1,DC=$DC2,DC=$DC3" }
$Path

	New-ADUser $Sam -samaccountname $sam -AccountPassword $Pwd -Path $Path`
	-Description $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot)`
	-GivenName $FName -Surname $LName -PassThru | Enable-ADAccount

	$A = ("ITSecurity","InfoSec_RW","Skybox-Sec","CiscoISE-Security")
	$Members = "CN=$sam,$Path"
	
	ForEach ($I in $A){
	Get-ADGroup $I |
	Add-ADGroupMember -Members $Members 
	}
	
	Set-ADUser $Sam -Description $Desc -manager $Man -title $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot)


Get-aduser $Sam -properties Manager, Description, title, UserPrincipalName

Get-ADUser -Filter 'Name -like $Sam' | Enable-ADAccount