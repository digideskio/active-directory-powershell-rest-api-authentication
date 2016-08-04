<#
	The sample scripts are not supported under any Microsoft standard support 
	program or service. The sample scripts are provided AS IS without warranty  
	of any kind. Microsoft further disclaims all implied warranties including,  
	without limitation, any implied warranties of merchantability or of fitness for 
	a particular purpose. The entire risk arising out of the use or performance of  
	the sample scripts and documentation remains with you. In no event shall 
	Microsoft, its authors, or anyone Else involved in the creation, production, or 
	delivery of the scripts be liable for any damages whatsoever (including, 
	without limitation, damages for loss of business profits, business interruption, 
	loss of business information, or other pecuniary loss) arising out of the use 
	of or inability to use the sample scripts or documentation, even If Microsoft 
	has been advised of the possibility of such damages 
#>

Function New-AzureRestAuthorizationHeader
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$true)][String]$ClientId,
		[Parameter(Mandatory=$true)][String]$ClientKey,
		[Parameter(Mandatory=$true)][String]$TenantId
	)


	# Import ADAL library to acquire access token
	# $PSScriptRoot only work PowerShell V3 or above versions
	Add-Type -Path "$PSScriptRoot\libs\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
	Add-Type -Path "$PSScriptRoot\libs\Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll"

	# Authorization & resource Url
	$authUrl = "https://login.windows.net/$TenantId/"
	$resource = "https://management.core.windows.net/"

	# Create credential for client application
	$clientCred = [Microsoft.IdentityModel.Clients.ActiveDirectory.ClientCredential]::new($ClientId, $ClientKey)

	# Create AuthenticationContext for acquiring token
	$authContext = [Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext]::new($authUrl, $false)

	# Acquire the authentication result
	$authResult = $authContext.AcquireTokenAsync($resource, $clientCred).Result

	# Compose the access token type and access token for authorization header
	$authHeader = $authResult.AccessTokenType + " " + $authResult.AccessToken

	# the final header hash table
	return @{"Authorization"=$authHeader; "Content-Type"="application/json"}
}

Export-ModuleMember -Function "New-AzureRestAuthorizationHeader"
