$files= get-content quicken_rename.txt
foreach ($file in $files) {
set-content $file ("B2B_" + $file + "_DRCT_00173_00174" ) 
} 
$Quicken=get-childitem
foreach ($Item in $Quicken) {
Rename-Item $item.name ($item.name + ".txt")}

$combine = (dir *.txt)
$outfile = "out2.txt"

$combine | %{
       Get-Content $_.FullName | Add-Content $outfile
}

