Function New-ZomentumSalesTask {
    <#
        .SYNOPSIS
            Creates a Sales Task via the zomentum API.
        .DESCRIPTION
            Function to send an Sales Task creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to create a new action.
        [Parameter( Mandatory = $True )]
        [Object]$SalesTask
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $SalesTask -Endpoint 'activities/sales/task/'
        Return $Result

    } catch {
        Write-Error "Create Sales Task Failed $_"
    }

    
}