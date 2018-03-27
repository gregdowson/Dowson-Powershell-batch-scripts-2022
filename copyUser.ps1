$CopyFromUser = Get-ADUser mcentrella -prop MemberOf
$CopyToUser = Get-ADUser cowanspiege -prop MemberOf
$CopyFromUser.MemberOf | Where{$CopyToUser.MemberOf -notcontains $_} |  Add-ADGroupMember -Members $CopyToUser