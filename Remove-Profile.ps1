$A = @("David.Smith","Jessica.Davis","David.Honeyman","Jennifer.Terry","Jeff.Kelly","Danielle.Hernandez","Bernice.Cullum","Lisa.Congelliere")
Foreach ($i in $A) {
cd X:\NMIProfiles
$path = "$i.NMI.V2"
Write-host $path
If (test-path $Path) {
rm -r $Path
}
}
E: