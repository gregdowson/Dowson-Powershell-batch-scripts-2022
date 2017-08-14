<#
.SYNOPSIS
   Goes to the directory entered by the user, and in that directory puts the files into folders named by their file names. 
#>
$Folder = Read-Host "Enter Directory, i.e C:\scripts"

Get-ChildItem $Folder | Where-Object {!$_.PSIsContainer} | Foreach-Object {

    $dest = Join-Path $_.DirectoryName $_.BaseName.Split()[0]
    

    if(!(Test-Path -Path $dest -PathType Container))
    {
        $null = md $dest
    }

    $_ | Move-Item -Destination $dest -Force}