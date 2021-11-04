function Get-ZomentumSalesMeetings {
     <#
        .SYNOPSIS
            Gets Sales Meetings from the Zomentum API.
        .DESCRIPTION
            Retrieves Sales Meetings from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Sales Meeting ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$MeetingID,
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
  
    if ($MeetingID) {
        Write-Verbose "Fetching Single Meeting"
        $Meetings = Invoke-ZomentumRequest -method get -resource "activities/sales/meeting/$MeetingID"
    } else {
        $QueryString = ''
        if ($EntityType) {
            $QueryString = $QueryString + "&entity_type=$EntityType"
        }
        if ($EntityID) {
            $QueryString = $QueryString + "&entity_id=$EntityID"
        }
        Write-Verbose "Fetching Multiple Meetings"
        $Meetings = Invoke-ZomentumRequest -method get -resource "activities/sales/meeting" -Filters $Filters -MultiFetch -QueryString $QueryString
    }
    return $Meetings
  
}