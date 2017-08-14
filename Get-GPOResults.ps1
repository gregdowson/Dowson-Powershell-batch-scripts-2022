#Initialize Variables
$SRVS = gc c:\scripts\ServerList.txt
$ComputerName = $env:computername
ForEach($srv in $SRVS) {
$OutputFile = "Y:\IT\InfoSec\Audit Stuff\ITGC\2016\SOX Q4 2016\GPO-Results\$ComputerName-GPOExport.html"
$UserName = "mfadmin"

#The first thing we do is create an instance of the GPMgmt.GPM object. We can use this object if the Group Policy Management Console is installed in the computer.

$gpm = New-Object -ComObject GPMgmt.GPM
#Next step is to obtain all constants and save it in a variable.

$constants = $gpm.GetConstants()

#Now create reference RSOP object using required constants.

$gpmRSOP = $GPM.GetRSOP($Constants.RSOPModeLogging,$null,0)

#Next step is to specify Target Computer and User.

$gpmRSOP.LoggingComputer = $srv
$gpmRSOP.LoggingUser = $UserName

#Note: If we need the RSOP data for only Computer without considering User imposed Group Policy data, 
#we need to use "RsopLoggingNoUser" constant value instead of $gpmRSOP.LoggingUser.

$gpmRSOP.LoggingFlags = $Constants.RsopLoggingNoUser
#Next step is to query the target computer for RSOP GPO data.

$gpmRSOP.CreateQueryResults()
#To export data to a output file below command is used.

#HTML:

$gpmRSOP.GenerateReportToFile($constants.ReportHTML,$outputfile)
}
<#

$script='C:\Windows\System32\GPResult.exe /SCOPE Computer /H "Y:\Logs\GPO-Results\%COMPUTERNAME%-GPOExport.html"'
psexec -s @C:\Scripts\Full-ServerList.txt C:\Windows\System32\GPResult.exe /SCOPE Computer /H "Y:\Logs\GPO-Results\%COMPUTERNAME%-GPOExport.html"

GPResult.exe /SCOPE Computer /H "Y:\Logs\GPO-Results\%COMPUTERNAME%-GPOExport.html"

#>

# SIG # Begin signature block
# MIIELQYJKoZIhvcNAQcCoIIEHjCCBBoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUuABSpnCUJMUT+p/6gLKSMBY5
# 5DWgggI9MIICOTCCAaagAwIBAgIQauf5g1Cv+YdHGdCotWEEPTAJBgUrDgMCHQUA
# MCYxJDAiBgNVBAMTG1Bvd2VyU2hlbGwgVGVzdCBDZXJ0aWZpY2F0ZTAeFw0xNjEx
# MTUxNzQxNTlaFw0zOTEyMzEyMzU5NTlaMCYxJDAiBgNVBAMTG1Bvd2VyU2hlbGwg
# VGVzdCBDZXJ0aWZpY2F0ZTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAzm6g
# pIqGojHv7qckfPG5SdYN7R32/QjEn6fKcM1SD+gQ67CczBCjs2oZXBj2H5U8RnLc
# yJuu9ITlLnx1C1R5VMHUDtBlfrEmgtOfuJFOQrbSs4/FgAzZmgqP6NdyzBX0ZV+h
# TtCNr6q+VcfZHg/Qgc3OP36jZujYIU2knFoL1CUCAwEAAaNwMG4wEwYDVR0lBAww
# CgYIKwYBBQUHAwMwVwYDVR0BBFAwToAQbjevQNTOCWi9oNUhCD2JqKEoMCYxJDAi
# BgNVBAMTG1Bvd2VyU2hlbGwgVGVzdCBDZXJ0aWZpY2F0ZYIQauf5g1Cv+YdHGdCo
# tWEEPTAJBgUrDgMCHQUAA4GBABaPAqkQOlvis8u5yEqc3F93tqbnNoeMjG3x/CbJ
# 2NHS8o+1H61tV9PmbvmMYVbw2VUdBLxlAkc2/bOe8HF5+1k+Dsn8b9TWszZ7ZVry
# JYJWtyr5SKjUfzQEy5C7pDwyg6B8qdhU1vP92GW/rdSTVVKKFdYOuLsOslAw50hw
# kkqpMYIBWjCCAVYCAQEwOjAmMSQwIgYDVQQDExtQb3dlclNoZWxsIFRlc3QgQ2Vy
# dGlmaWNhdGUCEGrn+YNQr/mHRxnQqLVhBD0wCQYFKw4DAhoFAKB4MBgGCisGAQQB
# gjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYK
# KwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFHJwNuKt
# +9EmFo1r2JIaOR0JeMHwMA0GCSqGSIb3DQEBAQUABIGACMtG2HNHMfVP+aMlMrV4
# e3th94nzFZ7fTAtFgC2Anz2HKoVwr1IgPZoYPAFMojM7ewJmH2avuSYWC5hox8Rc
# tXgPwFmRQJEkYfBgz748A9x1ayNEjgSYeaFkl1BoeBsqNYxBVgc8OXcoIkYsB7wI
# VxOCS78+ogw3w7JaR5dgkWQ=
# SIG # End signature block
