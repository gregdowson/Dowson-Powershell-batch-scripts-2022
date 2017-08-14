$username = get-content "C:\Scripts\username.txt"

foreach ($user in $username)

{Get-ChildItem -Path  '\\nmi.local\files\NMIDocs\$user\AppData\Roaming\Mozilla\Firefox\Profiles\*' -Recurse -exclude 'places.sqlite' |
Select -ExpandProperty FullName |
Where {$_ -notlike '\\nmi.local\files\NMIDocs\$user\AppData\Roaming\Mozilla\Firefox\Profiles\*\*'} |
sort length -Descending |
Remove-Item -force}
