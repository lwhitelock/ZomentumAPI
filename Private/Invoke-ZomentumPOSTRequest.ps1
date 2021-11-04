#Requires -Version 7
function New-ZomentumPOSTRequest {
    <#
    .SYNOPSIS
        Sends a formatted web request to the Zomentum API.
    .DESCRIPTION
        Wrapper function to send new or set requests to the Zomentum API
    .OUTPUTS
        Outputs an object containing the response from the web request.
    #>
    [CmdletBinding()]
    Param(
        # If Updating
        [switch]$Update,
        # Object to Update / Create
        [Parameter( Mandatory = $True )]
        [PSCustomObject]$Object,
        # Endpoint to use
        [Parameter( Mandatory = $True )]
        [string]$Endpoint
    )
    try {
        if ($Update) {
            if ($null -eq $Object.id) {
                Throw 'Updates must have an ID'
            }
            $Endpoint = $Endpoint + $Object.id
            $Object.PSObject.Properties.Remove('id')
            $Method = 'PUT'

        } else {
            if ($null -ne $Object.id) {
                Throw 'Creates must not have an ID'
            }
            $Method = 'POST'
        }

        $RequestSplat = @{
            Method   = $Method
            Resource = $Endpoint
            Body     = $Object | ConvertTo-JSON -depth 100
        }

        Write-Verbose "Method: $($RequestSplat.Method)"
        Write-Verbose "Resource: $($RequestSplat.Resource)"
        Write-Verbose "Body: $($RequestSplat.Body)"
        
        $Results = Invoke-ZomentumRequest @RequestSplat
        Return $Results
    } catch {
        Write-Error "Create/Update Failed $_" 
    }
}