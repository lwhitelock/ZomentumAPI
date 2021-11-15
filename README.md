
## Release Notes
### 0.3 Release
Added IncludeChildren options
### 0.2 Release
Fixed Refresh Token Authorization after Zomentum fix.
Fixed Get Company
### 0.1 Base Release

## Notes
This is an unofficial powershell module to allow access to the Zomentum API. I am not associated with Zomentum other than as a customer.

## Installation
Install-Module  ZomentumAPI

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
### Include extra information.
Some of the multifetch commands support fetching more than just the default information. To utilize this you can add a -IncludeChildren parameter with a string in the format of: "documents:all,sales_activities:action_status"

The complete list of options are:
```
activities:all
blocks:current_revision
client_users:all
client_users:count
comments:all
documents:all
opportunities:all
users:all
client_companies:name
companies:all
opportunities:count
opportunities:name
sales_activities:action_status
assessment_logs:all
assessment_logs:blocks
qbr_health_status:block
qbr_risk_matrix:blocks
qbr_logs:blocks", "tax:all
parent_entity:summary
async_operation:operation_status
merge_tags:all
approval_automation_rules:all
document:needs_signature
client_details:sync_data
```

## Commands
### Connecting
Please refer to the Zomentum API Docs (https://api-docs.zomentum.com/) for details on obtaining your tokens.
#### Connect-Zomentum
You can connect to the Zomentum API by using either an access token or a refresh token. Using a refresh token will invalidate your previous access token. Access tokens are valid for 24 hours.
```PowerShell
Connect-Zomentum -AccessToken $AccessToken
Connect-Zomentum -RefreshToken $RefreshToken
```
### Get Commands
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
This should return your own company, but at present it returns all client objects
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
#### Get-ZomentumOpportunities
```PowerShell
Get-ZomentumOpportunities -OpportunityID "1234vgcdfgd123"
Get-ZomentumOpportunities -Filters $ExampleFilters -PipelineID "1234abcdef1234"
```
#### Get-ZomentumPipelines
```Powershell
Get-ZomentumPipelines -PipelineID "1234asbbf1234"
Get-ZomentumPipelines -Filters $ExampleFiters
```
#### Get-ZomentumProducts
```Powershell
Get-ZomentumProducts -ProductID "1234asbbf1234"
Get-ZomentumProducts -Filters $ExampleFiters
```
#### Get-ZomentumSalesMeetings
```PowerShell
Get-ZomentumSalesMeetings -MeetingID "1234vgcdfgd123"
Get-ZomentumSalesMeetings -Filters $ExampleFilters -EntityType ["client_company" / "opportunity"] -EntityID "12345asdbb1234"
```
#### Get-ZomentumSalesTasks
```PowerShell
Get-ZomentumSalesTasks -TaskID "1234vgcdfgd123"
Get-ZomentumSalesTasks -Filters $ExampleFilters -EntityType ["client_company" / "opportunity"] -EntityID "12345asdbb1234"
```
#### Get-ZomentumTaxCategory
```Powershell
Get-ZomentumTaxCategory -TaxCatID "1234asbbf1234"
Get-ZomentumTaxCategory -Filters $ExampleFiters
```
#### Get-ZomentumTaxRegion
```Powershell
Get-ZomentumTaxRegion -TaxRegionID "1234asbbf1234"
Get-ZomentumTaxRegion -Filters $ExampleFiters
```
#### Get-ZomentumUsers
```Powershell
Get-ZomentumUsers -UserID "1234asbbf1234"
Get-ZomentumUsers -Filters $ExampleFiters
```
### New Commands
For new commands the examples show only the required fields. To see all the available fields please consult the API documentation https://api-docs.zomentum.com/
#### New-ZomentumCallLog
```PowerShell
$NewCallLog = @{
    title = "API Created Call Log"
    outcome = "connected"
    entity_id = "ClientID1234abcd1234556"
    entity_type = "client_company"
    date_time = "$(Get-Date -format 'o')"
}
New-ZomentumCallLog -CallLog $NewCallLog
```
#### New-ZomentumClient
```PowerShell
$NewClient = @{
    name = "API Created Test Company"
}
New-ZomentumClient -Client $NewClient
```
#### New-ZomentumContact
```PowerShell
$NewContact = [ordered]@{
    name = @{
        first = "API Created"
        last = "Contact"
    }
    client_company_id = "ClientID1234abcd1234556"
    contact_type = "primary_contact"
}
New-ZomentumContact -Contact $NewContact
```
#### New-ZomentumEmailLog
```PowerShell
$NewEmailLog = @{
    title = "API Created Email Log"
    entity_id = "ClientID1234abcd1234556"
    entity_type = "client_company"
    date_time = "$(Get-Date -format 'o')"
}
New-ZomentumEmailLog -EmailLog $NewEmailLog
```
#### New-ZomentumOpportunity
```PowerShell
$NewOpportunity = @{
    name = "API Created Opportunity"
    client_company_id = "ClientID1234abcd1234556"
    linked_client_user_ids = @("abcdefg12345gfdsa")
    opportunity_pipeline_id = "cdefgh432312fdsberea"
    opportunity_pipeline_stage_id = "efgh54321dfgdfghdfs"
}
New-ZomentumOpportunity -Opportunity $NewOpportunity
```
#### New-ZomentumProduct
```PowerShell
$NewProduct = @{
    name        = "API Created Product"
    type        = "service"
    description = "This is a test product created through the API"
    item_images = @("https://assets.website-files.com/5d9c347f1416aefa5128c8c3/5fc1e7baf194774abf44f2a2_zomentum%20white%20logo.png")
    pricing     = @(
        @{
            name           = "Example Pricing"
            billing_period = "monthly"
            sell_price     = 13.00
            setup_price    = 13.00
        }
    )
}
New-ZomentumProduct -Product $NewProduct
```
#### New-ZomentumSalesMeeting
```PowerShell
$Date = Get-Date
$NewSalesMeeting = @{
    meeting_title = "API Created Sales Meeting"
    date_time = "$(Get-Date($Date) -format 'yyyy-MM-ddTHH:mm:00+0000')"
    end_date_time = "$(Get-Date($Date.AddMinutes(10)) -format 'yyyy-MM-ddTHH:mm:00+0000')"
    entity_id = "ClientID1234abcd1234556"
    entity_type = "client_company"
    is_all_day = $false
    attendees = @(
        @{
            attendee_id = "abcdefg12345gfdsa"
            attendee_type = "user"
        }
    )
    all_reminder_details = @(
        @{
            reminder_type = "in_app_notification"
            sales_activity_reminder_unit = "minute"
            reminder_interval = 15
        }
    )
}
New-ZomentumSalesMeeting -SalesMeeting $NewSalesMeeting
```
#### New-ZomentumSalesTask
```PowerShell
$NewSalesTask = @{
    title = "API Created Sales Task"
    entity_id = "ClientID1234abcd1234556"
    entity_type = "client_company"
    date_time = "$(Get-Date -format 'o')"
    priority = "medium"
    is_marked_completed = $false
}
New-ZomentumSalesTask -SalesTask $NewSalesTask
```
### Set Commands
Set Commands use the same format as New Commands except you need to include the ID of the object you are updating. For example:
```PowerShell
$UpdateClient = @{
    id = "ClientID1234abcd1234556"
    name = "API Created Test Company Updated"
}
Set-ZomentumClient -Client $UpdateClient
```

The avalible commands are:
```PowerShell
Set-ZomentumCallLog
Set-ZomentumClient
Set-ZomentumContact
Set-ZomentumEmailLog
Set-ZomentumOpportunity
Set-ZomentumProduct
Set-ZomentumSalesMeeting
Set-ZomentumSalesTask
``` 
