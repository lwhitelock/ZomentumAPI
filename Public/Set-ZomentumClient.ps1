Function Set-ZomentumClient {
    <#
        .SYNOPSIS
            Updates a client via the zomentum API.
        .DESCRIPTION
            Function to send an client creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Client
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Client -Endpoint 'client/companies/' -Update
        Return $Result

    } catch {
        Write-Error "Update Client Failed $_"
    }
}