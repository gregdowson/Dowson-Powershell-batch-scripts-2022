$source = "C:\users\gdadmin\scripts"

$archive = "C:\users\gadmin\Archive"

$Name = "Script.zip"

$destination = "\\dc1\share\scripts"

$ArchiveFile = Join-Path -Path $archive -ChildPath $Name

MD $archive -EA 0 | Out-Null

If(Test-path $ArchiveFile) {Remove-item $ArchiveFile}

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($Source, $ArchiveFile)

Copy-Item -Path $ArchiveFile -Destination $destination -Force
