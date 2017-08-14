
$Users= @("mrfadmin")
ForEach ($Sam in $Users){
$user = Get-aduser $sam
get-adgroup "CN=vSphereAdmins,CN=Users,DC=NMI,DC=local" | 
add-adgroupmember -Members $user

get-adgroup "CN=vSphereAdmins_STG,CN=Users,DC=NMI,DC=local" | 
add-adgroupmember -Members $user
}
