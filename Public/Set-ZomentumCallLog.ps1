Function Set-ZomentumCallLog {
    <#
        .SYNOPSIS
            Updates a call log via the zomentum API.
        .DESCRIPTION
            Function to send a call log creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to Update a new action.
        [Parameter( Mandatory = $True )]
        [Object]$CallLog
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $CallLog -Endpoint 'activities/sales/call_log/' -Update
        Return $Result

    } catch {
        Write-Error "Update Call Log Failed $_"
    }
}