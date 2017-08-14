Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn
$name=Read-Host "Enter login name of user to hide"
Set-Mailbox -Identity nmi\$name -HiddenFromAddressListsEnabled $true