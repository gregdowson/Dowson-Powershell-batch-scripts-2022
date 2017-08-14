$A = @("Jaclyn.Barnhart","Shelby.Bryan","Askia.Howell","Stan.Adams","Christopher.Holm")
sl X:\NMIProfiles

Foreach ($i in $A){
$User = "$i.NMI.V2"
$User
	If (Test-Path X:\NMIProfiles\$User) {

	Get-ChildItem -Path $User -Recurse | Remove-Item -force -recurse

	rm -r $User -Force
	}
}