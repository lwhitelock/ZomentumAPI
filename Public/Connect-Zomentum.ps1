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
            $Response = Invoke-WebRequest -Method Get -Uri "https://api.zomentum.com/v2/auth0/access_token?refresh_token=$RefreshToken" -ContentType 'application/json'
            #TODO: Set the correct token from the response
            $Script:ZomentumBearerToken = $Response.Token
        } catch {
            Throw "Unable to Refresh Zomentum Access Token: $_"
        }
    }
        

}