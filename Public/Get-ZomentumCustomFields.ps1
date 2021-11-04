function Get-ZomentumCustomFields {
     <#
        .SYNOPSIS
            Gets Custom Fields from the Zomentum API.
        .DESCRIPTION
            Retrieves Custom Fields from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Contact ID for retrieving a custom field
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$CustomFieldID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple', Mandatory = $True)]
        [ValidateSet("client_company","opportunity","client_user","item","document")]
        [string]$EntityType
    )
  
    if ($CustomFieldID) {
        Write-Verbose "Fetching Single Contact"
        $CustomFields = Invoke-ZomentumRequest -method get -resource "custom/fields/$CustomFieldID"
    } else {
        Write-Verbose "Fetching Multiple Contacts"
        $QueryString = "&entity_type=$EntityType"
        $CustomFields = (Invoke-ZomentumRequest -method get -resource "custom/fields?$QueryString").data
    }
    return $CustomFields
  
}