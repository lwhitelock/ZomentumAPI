function Get-ZomentumClients {
     <#
        .SYNOPSIS
            Gets Clients from the Zomentum API.
        .DESCRIPTION
            Retrieves clients from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Client ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$ClientID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters,
        # The Child entities to include with the records.
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$IncludeChildren
    )
  
    if ($ClientID) {
        Write-Verbose "Fetching Single Client"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies/$ClientID"
    } else {
        $QueryString = ''
        if ($IncludeChildren){
            $QueryString = $QueryString + "&included_child_entities=$IncludeChildren"
        }
        Write-Verbose "Fetching Multiple Clients"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies" -Filters $Filters -MultiFetch
    }
    return $Clients
  
}