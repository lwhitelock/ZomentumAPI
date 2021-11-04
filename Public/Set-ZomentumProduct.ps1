Function Set-ZomentumProduct {
    <#
        .SYNOPSIS
            Updates a Product via the zomentum API.
        .DESCRIPTION
            Function to send an Product creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Product
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Product -Endpoint 'items/' -Update
        Return $Result

    } catch {
        Write-Error "Update Product Failed $_"
    }

    
}