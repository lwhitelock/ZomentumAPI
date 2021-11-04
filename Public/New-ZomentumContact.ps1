Function New-ZomentumContact {
    <#
        .SYNOPSIS
            Creates a Contact via the zomentum API.
        .DESCRIPTION
            Function to send an Contact creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to create a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Contact
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Contact -Endpoint 'client/users/'
        Return $Result

    } catch {
        Write-Error "Create Contact Failed $_"
    }
}