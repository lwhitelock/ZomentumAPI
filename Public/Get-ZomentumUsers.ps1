function Get-ZomentumUsers {
     <#
        .SYNOPSIS
            Gets Users from the Zomentum API.
        .DESCRIPTION
            Retrieves Users from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # User ID for retrieving a single User
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$UserID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($UserID) {
        Write-Verbose "Fetching Single User"
        $Users = Invoke-ZomentumRequest -method get -resource "users/$UserID"
    } else {
        Write-Verbose "Fetching Multiple Users"
        $Users = Invoke-ZomentumRequest -method get -resource "users" -Filters $Filters -MultiFetch
    }
    return $Users
  
}