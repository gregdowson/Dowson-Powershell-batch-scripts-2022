Import-Module ActiveDirectory
$Users = Import-csv D:\scripts\PS1\logonID.csv
foreach($User in $Users){
$ID = $($User.LoginID)
$Desc = $($User.Description)
$Man = $($User.Manager)

Write-host "$id $Desc $Man"

Set-ADUser $ID -Description $Desc -manager $Man -title $Desc

}