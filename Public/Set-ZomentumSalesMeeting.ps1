Function Set-ZomentumSalesMeeting {
    <#
        .SYNOPSIS
            Updates a Sales Meeting via the zomentum API.
        .DESCRIPTION
            Function to send an Sales Meeting creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$SalesMeeting
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $SalesMeeting -Endpoint 'activities/sales/meeting/' -Update
        Return $Result

    } catch {
        Write-Error "Update Sales Meeting Failed $_"
    }

    
}