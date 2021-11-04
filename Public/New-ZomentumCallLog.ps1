Function New-ZomentumCallLog {
    <#
        .SYNOPSIS
            Creates a call log via the zomentum API.
        .DESCRIPTION
            Function to send a call log creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to create a new action.
        [Parameter( Mandatory = $True )]
        [Object]$CallLog
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $CallLog -Endpoint 'activities/sales/call_log/'
        Return $Result

    } catch {
        Write-Error "Create Call Log Failed $_"
    }
}