Function New-ZomentumEmailLog {
    <#
        .SYNOPSIS
            Creates a Email Log via the zomentum API.
        .DESCRIPTION
            Function to send an EmailLog creation request to the Halo API
        .OUTPUTS
            Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param (
        # Object containing properties and values used to create a new action.
        [Parameter( Mandatory = $True )]
        [Object]$EmailLog
    )
    try {

        $Result = New-ZomentumPOSTRequest -Object $EmailLog -Endpoint 'activities/sales/email_log/'
        Return $Result

    } catch {
        Write-Error "Create Email Log Failed $_"
    }
}