
## Release Notes
0.1 Base Release

## Notes
This is an unofficial powershell module to allow access to the Zomentum API. I am not associated with Zomentum other than as a customer.

## Installation
Install-Module  ZomentumAPI

## Implemented Commands
Connect-Zomentum

Get-ZomentumClients

Get-ZomentumCallLogs

Get-ZomentumCompany

Get-ZomentumContacts

Get-ZomentumCustomFields

Get-ZomentumDocuments

Get-ZomentumEmailLog

## Usage
### Filtering
For filtering requests in the Zomentum API please refer to the Zomentum API Docs (https://api-docs.zomentum.com/) to see the supported filters and field names for each endpoint.
You can then pass in a PowerShell object like below defining the filters you wish to use to the -Filters paramater of the Get- Commands
```PowerShell
$ExampleFilters = @(
			@{
				field    = "phone"
				operator = "eq"
				value    = "1234566789"
			},
			@{
				field    = "outcome"
				operator = "eq"
				value    = "connected"
			}
		)
```
### Commands
#### Connect-Zomentum
You can connect to the Zomentum API by using either an access token or a refresh token. Using a refresh token will invalidate your previous access token. Access tokens are valid for 24 hours.
```PowerShell
Connect-Zomentum -AccessToken $AccessToken
Connect-Zomentum -RefreshToken $RefreshToken
```

