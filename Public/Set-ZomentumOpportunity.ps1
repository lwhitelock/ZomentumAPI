Function Set-ZomentumOpportunity {
    <#
        .SYNOPSIS
            Updates a Opportunity via the zomentum API.
        .DESCRIPTION
            Function to send an Opportunity creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Opportunity
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Opportunity -Endpoint 'opportunities/' -Update
        Return $Result

    } catch {
        Write-Error "Update Opportunity Failed $_"
    }
}