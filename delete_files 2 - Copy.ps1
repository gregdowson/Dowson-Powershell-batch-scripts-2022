Get-ChildItem -Path  '\\nmi.local\files\NMIDocs\*\AppData\Roaming\Mozilla\Firefox\Profiles\*' -Recurse -exclude 'places.sqlite' |
Select -ExpandProperty FullName |
Where {$_ -notlike '\\nmi.local\files\NMIDocs\*\AppData\Roaming\Mozilla\Firefox\Profiles\*\*'} |
sort length -Descending |
Remove-Item -force -confirm



