function Get-ZomentumProducts {
     <#
        .SYNOPSIS
            Gets Products from the Zomentum API.
        .DESCRIPTION
            Retrieves Products from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Product ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$ProductID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($ProductID) {
        Write-Verbose "Fetching Single Product"
        $Products = Invoke-ZomentumRequest -method get -resource "items/$ProductID"
    } else {
        Write-Verbose "Fetching Multiple Products"
        $Products = Invoke-ZomentumRequest -method get -resource "items" -Filters $Filters -MultiFetch
    }
    return $Products
  
}