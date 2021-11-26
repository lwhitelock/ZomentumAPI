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
        [Parameter( ParameterSetName = 'Single')]
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$IncludeChildren
    )
    $QueryString = ''
    if ($ClientID) {
        if ($IncludeChildren){
            $QueryString = $QueryString + "?included_child_entities=$IncludeChildren"
        }
        Write-Verbose "Fetching Single Client"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies/$ClientID" -QueryString $QueryString
    } else {
        if ($IncludeChildren){
            $QueryString = $QueryString + "&included_child_entities=$IncludeChildren"
        }
        Write-Verbose "Fetching Multiple Clients"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies" -Filters $Filters -MultiFetch
    }
    return $Clients
  
}