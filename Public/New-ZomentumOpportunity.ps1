Function New-ZomentumOpportunity {
    <#
        .SYNOPSIS
            Creates a Opportunity via the zomentum API.
        .DESCRIPTION
            Function to send an Opportunity creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to create a new action.
        [Parameter( Mandatory = $True )]
        [Object]$Opportunity
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $Opportunity -Endpoint 'opportunities/'
        Return $Result

    } catch {
        Write-Error "Create Opportunity Failed $_"
    }
}