function Get-ZomentumSalesTasks {
     <#
        .SYNOPSIS
            Gets Sales Tasks from the Zomentum API.
        .DESCRIPTION
            Retrieves Sales Tasks from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Sales Task ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$TaskID,
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
  
    if ($TaskID) {
        Write-Verbose "Fetching Single Task"
        $Tasks = Invoke-ZomentumRequest -method get -resource "activities/sales/task/$TaskID"
    } else {
        $QueryString = ''
        if ($EntityType) {
            $QueryString = $QueryString + "&entity_type=$EntityType"
        }
        if ($EntityID) {
            $QueryString = $QueryString + "&entity_id=$EntityID"
        }
        Write-Verbose "Fetching Multiple Tasks"
        $Tasks = Invoke-ZomentumRequest -method get -resource "activities/sales/task" -Filters $Filters -MultiFetch -QueryString $QueryString
    }
    return $Tasks
  
}