
$groups = Get-ADGroup -filter * -SearchBase "OU=Alfresco,OU=AllGroups,DC=NMI,DC=local"

$Table = @()

$Record = @{
  "Group Name" = ""
  "Name" = ""
  "Username" = ""
}


Foreach ($Group in $Groups) {

  $Arrayofmembers = Get-ADGroupMember -identity $Group -recursive | select name,samaccountname

  foreach ($Member in $Arrayofmembers) {
    $Record."Group Name" = $Group.Name
    $Record."Name" = $Member.name
    $Record."UserName" = $Member.samaccountname
    $objRecord = New-Object PSObject -property $Record
    $Table += $objrecord

  }
}

$Table | export-csv "D:\logs\AlfrescoUsers.csv" -Notypeinformation