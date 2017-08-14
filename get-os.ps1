$Cred = Get-credential
$SRVS = gc c:\scripts\ServerList.txt
ForEach($Computer in $SRVS) {
if((Test-Connection -Cn $computer -BufferSize 16 -Count 1 -ea 0 -quiet))
    {   
       $OS = Get-WMIObject Win32_OperatingSystem -ComputerName $computer  -Credential $cred |
        select-object CSName, Caption, CSDVersion, OSType, LastBootUpTime, ProductType
		Write-host "$computer `t$OS"
    }
}
