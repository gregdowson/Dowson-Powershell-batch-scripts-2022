<#
.SYNOPSIS
   Goes to the folder entered by the user, and in that directory puts the files into folders named by their file names without the extension. 
#>
$Folder = Read-Host "Enter folder path, i.e. C:\reports"

Get-ChildItem $Folder | Where-Object {!$_.PSIsContainer} | Foreach-Object {

    $dest = Join-Path $_.DirectoryName $_.BaseName.Split()[0]
    

    if(!(Test-Path -Path $dest -PathType Container))
    {
        $null = md $dest
    }

    $_ | Move-Item -Destination $dest -Force}