

# Create new SB Farm
$SBCertAutoGenerationKey = ConvertTo-SecureString -AsPlainText -Force -String ***** Replace with Workflow Certificate Auto-generation key******
New-SBFarm -SBFarmDBConnectionString 'Data Source=localhost;Initial Catalog=SbManagementDB;Integrated Security=True' -InternalPortRangeStart 9000 -HttpsPort 9355 -TcpPort 9354 -MessageBrokerPort 9356 -RunAsName ‘userName@domain' -AdminGroup 'BUILTIN\Administrators' -GatewayDBConnectionString 'Data Source=localhost;Initial Catalog=SbGatewayDatabase;Integrated Security=True' -CertificateAutoGenerationKey $SBCertificateAutoGenerationKey -MessageContainerDBConnectionString 'Data Source=localhost;Initial Catalog=ServiceBusDefaultContainer;Integrated Security=True';

# Create new WF Farm
$WFCertAutoGenerationKey = ConvertTo-SecureString -AsPlainText -Force -String ***** Replace with Workflow Certificate Auto-generation key******;

New-WFFarm -WFFarmDBConnectionString 'Data Source=localhost;Initial Catalog=WFManagementDB;Integrated Security=True' -RunAsName 'userName@domain' -AdminGroup 'BUILTIN\Administrators' -HttpsPort 12290 -HttpPort 12291 -InstanceMgmtDBConnectionString 'Data Source=localhost;Initial Catalog=WFInstanceManagementDB;Integrated Security=True' -ResourceMgmtDBConnectionString 'Data Source=CSDVM991617-TA.redmond.corp.microsoft.com;Initial Catalog=WFResourceManagementDB;Integrated Security=True' -CertificateAutoGenerationKey $WFCertAutoGenerationKey;

# Add SB Host
$SBRunAsPassword = ConvertTo-SecureString -AsPlainText -Force -String ***** Replace with RunAs Password for Service Bus ******;

Add-SBHost -SBFarmDBConnectionString 'Data Source=localhost;Initial Catalog=SbManagementDB;Integrated Security=True' -RunAsPassword $SBRunAsPassword -EnableFirewallRules $true -CertificateAutoGenerationKey $SBCertificateAutoGenerationKey;

# Create new SB Namespace
New-SBNamespace -Name 'WorkflowDefaultNamespace' -AddressingScheme 'Path' -ManageUsers 'CurrentUser@yourDomain','WfRunAsUser@yourDomain';

# Get SB Client Configuration
$SBClientConfiguration = Get-sbclientConfiguration -Namespaces 'WorkflowDefaultNamespace';

# Add WF Host
# Copy the Service Bus Client configuration from Service Bus PowerShell console and store it in a local variable $SBClientConfiguration

$WFRunAsPassword = ConvertTo-SecureString -AsPlainText -Force  -String ***** Replace with RunAs Password for Workflow ******;

Add-WFHost -WFFarmMgmtDBConnectionString 'Data Source=localhost;Initial Catalog=WFManagementDB;Integrated Security=True' -RunAsPassword $WFRunAsPassword -SBClientConfiguration $SBClientConfiguration -EnableHttpPort -CertificateAutoGenerationKey $WFCertAutoGenerationKey -EnableFirewallRules $true;

Community Additions
ADD
Several bugs in this script
I tried using this sample script today on a fresh install of Windows Server 2012 standard. The script ran into several issues (parameter changes). I have included my working copy of the script below:

# Run it in the Workflow PowerShell Console

# Create new SB Farm
Write-Host -ForegroundColor Gray "Going to create servicebus Farm"
$SBCertAutoGenerationKey = ConvertTo-SecureString "P@ssW0rD!" -AsPlainText -Force;
New-SBFarm -SBFarmDBConnectionString 'Data Source=mymachinename;Initial Catalog=SbManagementDB;Integrated Security=True' -InternalPortRangeStart 9000 -HttpsPort 9355 -TcpPort 9354 -MessageBrokerPort 9356 -RunAsAccount 'DOMAIN\account' -AdminGroup 'DOMAIN\account' -GatewayDBConnectionString 'Data Source=mymachine;Initial Catalog=SbGatewayDatabase;Integrated Security=True' -CertificateAutoGenerationKey $SBCertAutoGenerationKey -MessageContainerDBConnectionString 'Data Source=mymachine;Initial Catalog=ServiceBusDefaultContainer;Integrated Security=True';

# Create new WF Farm
Write-Host -ForegroundColor Gray "Going to create workflow Farm"
$WFCertAutoGenerationKey = ConvertTo-SecureString "P@ssW0rD!" -AsPlainText -Force;
New-WFFarm -WFFarmDBConnectionString 'Data Source=mymachine;Initial Catalog=WFManagementDB;Integrated Security=True' -RunAsAccount 'DOMAIN\account' -AdminGroup 'DOMAIN\AdminGroup' -HttpsPort 12290 -HttpPort 12291 -InstanceDBConnectionString 'Data Source=mymachine;Initial Catalog=WFInstanceManagementDB;Integrated Security=True' -ResourceDBConnectionString 'Data Source=mymachine;Initial Catalog=WFResourceManagementDB;Integrated Security=True' -CertificateAutoGenerationKey $WFCertAutoGenerationKey;

# Add SB Host
$SBRunAsPassword = ConvertTo-SecureString "P@ssW0rD!" -AsPlainText -Force
Write-Host -ForegroundColor Gray "Add servicebus host"
Add-SBHost -SBFarmDBConnectionString 'Data Source=mymachine;Initial Catalog=SbManagementDB;Integrated Security=True' -RunAsPassword $SBRunAsPassword -EnableFirewallRules $true -CertificateAutoGenerationKey $SBCertAutoGenerationKey

# Create new SB Namespace
Write-Host -ForegroundColor Gray "New servicebus namespace"
New-SBNamespace -Name 'WorkflowDefaultNamespace' -AddressingScheme 'Path' -ManageUsers 'DOMAIN\account','DOMAIN\account';

# Add WF Host
# Copy the Service Bus Client configuration from Service Bus PowerShell console and store it in a local variable $SBClientConfiguration
$SBClientConfiguration = Get-sbclientConfiguration -Namespaces 'WorkflowDefaultNamespace';
$WFRunAsPassword = ConvertTo-SecureString "P@ssW0rD!" -AsPlainText -Force
Write-Host -ForegroundColor Gray "Add Workflow host"
Add-WFHost -WFFarmDBConnectionString 'Data Source=mymachine;Initial Catalog=WFManagementDB;Integrated Security=True' -RunAsPassword $WFRunAsPassword -SBClientConfiguration $SBClientConfiguration -EnableHttpPort -CertificateAutoGenerationKey $WFCertAutoGenerationKey -EnableFirewallRules $true;





 
