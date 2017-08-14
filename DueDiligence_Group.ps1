# NMIH-INTAD05

Try 
{ 
  Import-Module ActiveDirectory -ErrorAction Stop 
} 
Catch 
{ 
  Write-Host "[ERROR]`t ActiveDirectory Module couldn't be loaded. Script will stop!" 
  Exit 1 
} 

New-ADGroup -Name "Finance_Due_Diligence_RW" -SamAccountName "Finance_Due_Diligence_RW" -GroupCategory Security -GroupScope Global -DisplayName "Finance_Due_Diligence_RW" -Path "OU=Security_Groups,OU=AllGroups,DC=NMI,DC=local" -Description "CR00004732 R/W access to Finance Due Diligence folder "  

$A=@("Dawn.Janssen","Randall.Price","Catherine.Marini","Rebecca.Frazer","Christine.Econome","christopher.brunetti","Wendi.Arendell")

ForEach ($I in $A){
Get-ADGroup -searchbase 'OU=Security_Groups,OU=AllGroups,DC=NMI,DC=local' -filter { name -eq "Finance_Due_Diligence_RW" } |
Add-ADGroupMember -Members $I
}

