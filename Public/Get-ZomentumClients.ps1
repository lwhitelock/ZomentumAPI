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
        [PSCustomObject]$Filters
    )
  
    if ($ClientID) {
        Write-Verbose "Fetching Single Client"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies/$ClientID"
    } else {
        Write-Verbose "Fetching Multiple Clients"
        $Clients = Invoke-ZomentumRequest -method get -resource "client/companies" -Filters $Filters -MultiFetch
    }
    return $Clients
  
}