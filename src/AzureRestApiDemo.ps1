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

# change the $clientId $key and $tenantId according to your azure account and azure appliction
$clientId = "<Your application client Id>"
$key = "<Your application key>"
$tenantId = "<Your Azure tenant id>"

Function Invoke-AzureRestGetAPI
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$true)][String]$Uri
	)

	# import the module to help to compose the auth header
	Import-Module ".\NewAzureAuthRestHeader.psm1"
	
	# compose auth header for rest call
	$authHeader = New-AzureRestAuthorizationHeader -ClientId $clientId -ClientKey $key -TenantId $tenantId

	# invoke rest call
	Return Invoke-RestMethod -Method Get -Headers $authHeader -Uri $Uri
}

Function Invoke-AzureRestPostAPI
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$true)][String]$Uri,
		[Parameter(Mandatory=$true)][String]$Body
	)

	# import the module to help to compose the auth header
	Import-Module ".\NewAzureAuthRestHeader.psm1"
	
	# compose auth header for rest call
	$authHeader = New-AzureRestAuthorizationHeader -ClientId $clientId -ClientKey $key -TenantId $tenantId

	# invoke rest call
	Return Invoke-RestMethod -Method Post -Headers $authHeader -Uri $Uri -Body $Body
}

# GET Api
# Change the Uri to the proper Uri you need to call
Invoke-AzureRestGetAPI -Uri "https://management.azure.com/subscriptions/<the rest api uri sections>"

# POST Api
# Change the Uri to the proper Uri you need to call
# Change body information properly
Invoke-AzureRestPostAPI -Uri "https://management.azure.com/subscriptions/<the rest api uri sections>" -Body "<Post body information>"
