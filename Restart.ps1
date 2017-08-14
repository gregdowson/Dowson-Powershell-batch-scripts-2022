(Get-WmiObject win32_service -ComputerName fit-win-dfss-02.nmi.local,fit-win-pent-01.nmi.local,fit-win-smtp-01.nmi.local,	
fit-win-smtp-03.nmi.local | Where-Object {$_.Name -eq "teagent"}).StopService()
 