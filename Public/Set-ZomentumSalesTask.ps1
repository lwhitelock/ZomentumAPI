Function Set-ZomentumSalesTask {
    <#
        .SYNOPSIS
            Updates a Sales Task via the zomentum API.
        .DESCRIPTION
            Function to send an Sales Task creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$SalesTask
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $SalesTask -Endpoint 'activities/sales/task/' -Update
        Return $Result

    } catch {
        Write-Error "Update Sales Task Failed $_"
    }

    
}