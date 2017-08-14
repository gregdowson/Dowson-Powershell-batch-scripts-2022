<#
        .Synopsis 
            Gets membership information of local groups in remote computer

        .Description
            This script by default queries the membership details of local administrators group on remote computers. 
			It has a provision to query any local group in remote server, not just administrators group.

        .Parameter ComputerName
            Computer Name(s) which you want to query for local group information

		.Parameter LocalGroupName
			Name of the local group which you want to query for membership information. 

		.Parameter OutputDir
			Name of the folder where you want to place the output file. 
      

#>
[CmdletBinding()]
Param(
	[Parameter(	ValueFromPipeline=$true,
				ValueFromPipelineByPropertyName=$true
				)]
	[string[]]
	$ComputerName = $env:ComputerName,

	[Parameter()]
	[string]
	$LocalGroupName = "Administrators",

	[Parameter()]
	[string]
	$OutputDir = "\\fit-win-audt-01\D$\accessauditor\data"
)

Begin {

	$OutputFile = Join-Path $OutputDir "ServerAdmins.csv"
	Write-Verbose "Script will write the output to $OutputFile folder"
	Add-Content -Path $OutPutFile -Value "ComputerName, LocalGroupName, MemberType, MemberDomain, MemberName"
}

Process {
	ForEach($Computer in $ComputerName) {
		
		If(!(Test-Connection -ComputerName $Computer -Count 1 -Quiet)) {
			Write-Verbose "$Computer is offline. Proceeding with next computer"
			Add-Content -Path $OutputFile -Value "$Computer,$LocalGroupName,Offline"
			Continue
		} else {
			
			try {
				$group = [ADSI]"WinNT://$Computer/$LocalGroupName"
				$members = @($group.Invoke("Members"))
				Write-Verbose "Successfully queries the members of $computer"
				if(!$members) {
					Add-Content -Path $OutputFile -Value "$Computer,$LocalGroupName,NoMembersFound"
					Write-Verbose "No members found in the group"
					continue
				}
			}		
			catch {
				
				
				Continue
			}
			foreach($member in $members) {
				try {
					$MemberName = $member.GetType().Invokemember("Name","GetProperty",$null,$member,$null)
					$MemberType = $member.GetType().Invokemember("Class","GetProperty",$null,$member,$null)
					$MemberPath = $member.GetType().Invokemember("ADSPath","GetProperty",$null,$member,$null)
					$MemberDomain = $null
					if($MemberPath -match "^Winnt\:\/\/(?<domainName>\S+)\/(?<CompName>\S+)\/") {
						if($MemberType -eq "User") {
							$MemberType = "LocalUser"
						} elseif($MemberType -eq "Group"){
							$MemberType = "LocalGroup"
						}
						$MemberDomain = $matches["CompName"]

					} elseif($MemberPath -match "^WinNT\:\/\/(?<domainname>\S+)/") {
						if($MemberType -eq "User") {
							$MemberType = "DomainUser"
						} elseif($MemberType -eq "Group"){
							$MemberType = "DomainGroup"
						}
						$MemberDomain = $matches["domainname"]

					} else {
						$MemberType = "Unknown"
						$MemberDomain = "Unknown"
					}
				Add-Content -Path $OutPutFile -Value "$Computer, $LocalGroupName, $MemberType, $MemberDomain, $MemberName"
				} catch {
					
				}

			} 
		}

	}

}
End {}
