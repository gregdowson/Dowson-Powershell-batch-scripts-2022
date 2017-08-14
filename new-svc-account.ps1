
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
 
$CR = Read-Host "New users CR Number; CR00005784"
$Sam = Read-Host "New samAccountName; svc_cdw_commvault"
$FullName = Read-Host "New users Full Name; Michael Felkins"


$Desc = "CommVault Account $CR"
$Pwd = "Tree-View2017" | ConvertTo-SecureString -AsPlainText -Force
$dnsroot = '@' + (Get-ADDomain).dnsroot
$Man = "Charles.Latham"
$DC = (Get-ADDomain).dnsroot
	$DC = $DC.split(".")
	$DC1= $DC[0]
	$DC2= $DC[1]
	$DC3= $DC[2]
IF ($DC3 -eq $NULL){$Path = "OU=AllServiceAccounts,DC=$DC1,DC=$DC2" }
IF ($DC3){$Path = "OU=AllServiceAccounts,DC=$DC1,DC=$DC2,DC=$DC3" }
$Path

	New-ADUser $Sam -SamAccountName $sam -AccountPassword $Pwd -Path $Path`
	-Description $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot) -PassThru | Enable-ADAccount

<# 	$A = ("ITSecurity","InfoSec_RW","InfoSec_RW","CiscoISE-Security")
	$Members = "CN=$sam,$Path"
	
	ForEach ($I in $A){
	Get-ADGroup $I |
	Add-ADGroupMember -Members $Members 
	}
	 #>
	Set-ADUser $Sam -Description $Desc -manager $Man -title $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot)

$SamAc = $sam

Get-aduser -Filter "SamAccountName -eq '$($SamAc)'" -properties Manager, Description, title, UserPrincipalName

Get-aduser -Filter "SamAccountName -eq '$($SamAc)'" | Enable-ADAccount

