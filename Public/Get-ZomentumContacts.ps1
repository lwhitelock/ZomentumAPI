function Get-ZomentumContacts {
     <#
        .SYNOPSIS
            Gets Contacts from the Zomentum API.
        .DESCRIPTION
            Retrieves contacts from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Contact ID for retrieving a single contact
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$ContactID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($ContactID) {
        Write-Verbose "Fetching Single Contact"
        $Contacts = Invoke-ZomentumRequest -method get -resource "client/users/$ContactID"
    } else {
        Write-Verbose "Fetching Multiple Contacts"
        $Contacts = Invoke-ZomentumRequest -method get -resource "client/users" -Filters $Filters -MultiFetch
    }
    return $Contacts
  
}