# set variables

$Path = Read-Host “Enter path to check permissions on”

$OutFilePath = Read-Host “Enter path to store output file”

$ReportDate = Get-Date -format F

$ReportUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$FileTS = Get-Date -format “yyyy.M.dd.hh.mm.ss”

$ReportFileTS = $FileTS.replace(‘.’,”)

# check if path to output file exists, if not create it

if(!(Test-Path -Path $OutFilePath))

{

    ni -Path $OutFilePath –ItemType Directory -Force

}

# construct full path to output file

$FullOutFile = “$outfilepath\ACLCheckReport.$reportfilets.txt”

# add main report info

$RptNameInfo = “==============================`r`n    ACL Permissions Report    `r`n==============================”

$RptNameInfo | ft | Out-File $FullOutFile

$DateInfo = “Created on: $reportdate `r`nCreated by: $reportuser`r`n`==============================`r`n”

$DateInfo | ft | Out-File -append $FullOutFile

$NumFolders = (gci $Path -recurse | where {$_.PsIsContainer}).Count

$NumFiles = (gci $Path -recurse | where {$_.GetType() -match “fileInfo”} | measure-object).Count

$PathInfo = “Listing permissions for: $path ( Folders: $numfolders | Files: $numfiles )`r`n”

$PathInfo | ft | Out-File -append $FullOutFile

# fill array with folders and files

[Array] $Objects = gci -path $Path -force -recurse

# fill array with folders only

#[Array] $Objects = gci -path $path -force -recurse | Where {$_.PSIsContainer}

# process data in array

ForEach ($Object in [Array] $Objects)

{

# convert pspath to full system path

$PSPath = (Convert-Path $Object.PSPath)

# get the size of each folder/file

$PathSizeCount = (gci $PSPath -recurse | Measure-Object -property length -sum).Sum

$PathSizeCountKB = “{0:N2}” -f ($PathSizeCount / 1KB)

$PathSizeCountMB = “{0:N2}” -f ($PathSizeCount / 1MB)

# add path and size info for each folder/file to the report

$PathSizeInfo = (“Path: $PSPath `r`nSize (KBytes): $PathSizeCountKB | Size (MBytes): $PathSizeCountMB”)

$PathSizeInfo | ft | Out-File -append $FullOutFile

# run the get-acl command using the list of enumerated paths and format accordingly

Get-Acl -path $PSPath | fl -property Owner,AccessToString | Out-File -append $FullOutFile

}

