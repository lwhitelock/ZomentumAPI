
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

#### Get-ZomentumCallLogs
```PowerShell
Get-ZomentumCallLogs -CallLogID "1234vgcdfgd123"
Get-ZomentumCallLogs -Filters $ExampleFilters
```

#### Get-ZomentumClients
```PowerShell
Get-ZomentumClients -ClientID "1234vgcdfgd123"
Get-ZomentumClients -Filters $ExampleFilters
```
#### Get-ZomentumCompany
This should return your own company, but at present it returns all objects
```PowerShell
Get-ZomentumCompany
```
#### Get-ZomentumContacts
```PowerShell
Get-ZomentumContacts -ContactID "1234vgcdfgd123"
Get-ZomentumContacts -Filters $ExampleFilters
```
#### Get-ZomentumCustomFields
```PowerShell
Get-ZomentumCustomFields -CustomFieldID "1234vgcdfgd123"
Get-ZomentumCustomFields -EntityType ["client_company"/"opportunity"/"client_user"/"item"/"document"]
```
#### Get-ZomentumDocuments
```PowerShell
Get-ZomentumDocuments -DocumentID "1234vgcdfgd123" -OutPath "C:\Temp\"
Get-ZomentumDocuments -DocumentID "1234vgcdfgd123" -OutFile "C:\Temp\FileName.pdf"
Get-ZomentumDocuments -Filters $ExampleFilters
```
#### Get-ZomentumEmailLogs
```PowerShell
Get-ZomentumEmailLogs -EmailLogID "1234vgcdfgd123"
Get-ZomentumEmailLogs -Filters $ExampleFilters -EntityType ["client_company" / "opportunity"] -EntityID "12345asdbb1234"
```
