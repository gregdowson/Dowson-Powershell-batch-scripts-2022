$Servers = Get-Content "C:\users\gdowson-a\documents\servers.txt"
$Users = get-content "C:\users\gdowson-a\documents\VMSVF26 admins.txt"
$GroupName = "VMSVJ78\Adminsistrators"
$DomainName = $env:USERDOMAIN
$ErrorActionPreference = "Stop"
 
Foreach($Server in $Servers) {
    $Server = $Server.trim()
    $ComputerName = $Server
    Write-Host "Processing $ComputerName" -ForegroundColor Green
    Foreach($Username in $Users){
        Try{
            $Group = [ADSI]"WinNT://$ComputerName/$GroupName,group"
            $User = [ADSI]"WinNT://$DomainName/$Username,user"
            $Group.Add($User.Path)
        }
        Catch{
            $_.Exception.innerexception
            Continue
        }
    }
}