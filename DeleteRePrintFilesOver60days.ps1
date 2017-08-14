<# $a = Get-ChildItem C:\Scripts

foreach($x in $a)

    {

        $y = ((Get-Date) – $x.CreationTime).Days

        if ($y -gt 90 -and $x.PsISContainer -ne $True)

            {$x.Delete()}

    }
 #>
	
$limit = (Get-Date).AddDays(-60)
$path = "D:\RePrints"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | 
Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | 
Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse