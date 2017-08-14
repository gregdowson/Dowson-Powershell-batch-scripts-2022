
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

$Sam = Read-Host "New users samAccountName"
$Desc = "$sam Admin Account CR00005610"
$Pwd = "Tree-View2017" | ConvertTo-SecureString -AsPlainText -Force
#$Sam = "tsadmin" # Edit user name
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
	-PassThru | Enable-ADAccount

	$A = ("Domain Users","HelpDeskAdmins","PSafe_sfa","ITAdmins","SCCMInfoSec","DNS Read Only")
	$Members = "CN=$sam,$Path"
	
	ForEach ($I in $A){
	Get-ADGroup $I |
	Add-ADGroupMember -Members $Members 
	}
	
	Set-ADUser $Sam -Description $Desc -manager $Man -title $Desc -ChangePasswordAtLogon $True -UserPrincipalName ($Sam + $dnsroot)


Get-aduser $Sam -properties Manager, Description, title, UserPrincipalName
<# 

#Get all the Domain controllers
Get-ADDomainController -Filter * | Select-Object name

# Add properties to AD user
$Sam = "mgadmin"
$dnsroot = '@' + (Get-ADDomain).dnsroot
set-aduser mgadmin -UserPrincipalName ($Sam + $dnsroot) -ChangePasswordAtLogon $True

#>
