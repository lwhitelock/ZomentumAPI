function Get-ZomentumEmailLogs {
     <#
        .SYNOPSIS
            Gets Email Logs from the Zomentum API.
        .DESCRIPTION
            Retrieves Email Logs from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Client ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$EmailLogID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters,
        # Set the entity type to filter client_company or opportunity
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$EntityType,
        # The id of the entity associated with the email log.
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$EntityID

    )
  
    if ($EmailLogID) {
        Write-Verbose "Fetching Single Client"
        $EmailLogs = Invoke-ZomentumRequest -method get -resource "activities/sales/email_log/$EmailLogID"
    } else {
        Write-Verbose "Fetching Multiple Clients"
        $QueryString = ''
        if ($EntityType) {
            $QueryString = $QueryString + "&entity_type=$EntityType"
        }
        if ($EntityID) {
            $QueryString = $QueryString + "&entity_id=$EntityID"
        }
        $EmailLogs = Invoke-ZomentumRequest -method get -resource "activities/sales/email_log" -Filters $Filters -MultiFetch -QueryString $QueryString
    }

    return $EmailLogs
  
}