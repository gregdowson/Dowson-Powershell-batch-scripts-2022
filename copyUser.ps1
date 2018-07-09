$CopyFromUser = Get-ADUser fmwasilewski -prop MemberOf
$CopyToUser = Get-ADUser chanjn -prop MemberOf
$CopyFromUser.MemberOf | Where{$CopyToUser.MemberOf -notcontains $_} |  Add-ADGroupMember -Members $CopyToUser