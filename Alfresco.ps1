$names = gc alfresco security groups.txt

foreach ($name in names$)

{Get-ADGroupMember -identity $name | select name} 