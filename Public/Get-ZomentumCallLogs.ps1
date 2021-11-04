function Get-ZomentumCallLogs {
     <#
        .SYNOPSIS
            Gets Call Logs from the Zomentum API.
        .DESCRIPTION
            Retrieves Call Logs from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Client ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$CallLogID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($CallLogID) {
        Write-Verbose "Fetching Single Client"
        $CallLogs = Invoke-ZomentumRequest -method get -resource "activities/sales/call_log/$CallLogID"
    } else {
        Write-Verbose "Fetching Multiple Clients"
        $CallLogs = Invoke-ZomentumRequest -method get -resource "activities/sales/call_log" -Filters $Filters -MultiFetch
    }
    return $CallLogs
  
}