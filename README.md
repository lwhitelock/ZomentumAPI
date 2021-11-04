
## Release Notes
0.1 Base Release

## Notes
This is an unofficial powershell module to allow access to the Zomentum API. I am not associated with Zomentum other than as a customer.

## Installation
Install-Module  ZomentumAPI

## Implemented Commands


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