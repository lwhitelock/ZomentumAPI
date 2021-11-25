Function Set-ZomentumDocument {
    <#
        .SYNOPSIS
            Updates a Document via the zomentum API.
        .DESCRIPTION
            Function to send an Document creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Document
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Document -Endpoint 'documents/' -Update
        Return $Result

    } catch {
        Write-Error "Update Document Failed $_"
    }
}