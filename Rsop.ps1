<#
.SYNOPSIS
   <A brief description of the script>
.DESCRIPTION
   <A detailed description of the script>
.PARAMETER <paramName>
   <Description of script parameter>
.EXAMPLE
   <An example of using the script>
#>
$ServerName = Get-Content "c:\scripts\rdsh.txt"  
  
foreach ($Server in $ServerName) {
Get-GPResultantSetOfPolicy -Computer Computer1 -ReportType html -Path $pwdGPReport.htm
Invoke-Item $pwdGPReport.htm