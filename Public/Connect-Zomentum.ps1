function Connect-Zomentum {
    [CmdletBinding()]
    param(
        [string]$AccessToken,
        [string]$RefreshToken
    )

    if ($AccessToken) {
        $Script:ZomentumAccessToken = $AccessToken
        Write-Verbose "Zomentum Access Token Set"
    } else {
        Write-Verbose "Refreshing Zomentum Access Token"
        try {
            $Response = Invoke-RestMethod -Method Get -Uri "https://api.zomentum.com/v2/auth0/access_token?refresh_token=$RefreshToken"
            $Script:ZomentumAccessToken = $Response.access_token
        } catch {
            Throw "Unable to Refresh Zomentum Access Token: $_"
        }
    }
        

}