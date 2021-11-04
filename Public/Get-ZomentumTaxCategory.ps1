function Get-ZomentumTaxCategory {
     <#
        .SYNOPSIS
            Gets Tax categories from the Zomentum API.
        .DESCRIPTION
            Retrieves Tax categories from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Tax ID for retrieving a single Tax Category
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$TaxCatID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($TaxCatID) {
        Write-Verbose "Fetching Single Tax Category"
        $TaxCats = Invoke-ZomentumRequest -method get -resource "tax/categories/$TaxCatID"
    } else {
        Write-Verbose "Fetching Multiple Tax Categories"
        $TaxCats = Invoke-ZomentumRequest -method get -resource "tax/categories" -Filters $Filters -MultiFetch
    }
    return $TaxCats
  
}