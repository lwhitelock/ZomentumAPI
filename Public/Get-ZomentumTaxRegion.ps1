function Get-ZomentumTaxRegion {
     <#
        .SYNOPSIS
            Gets Tax Regions from the Zomentum API.
        .DESCRIPTION
            Retrieves Tax Regions from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Tax ID for retrieving a single Tax Region
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$TaxRegionID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($TaxRegionID) {
        Write-Verbose "Fetching Single Tax Region"
        $TaxRegs = Invoke-ZomentumRequest -method get -resource "tax/regions/$TaxRegionID"
    } else {
        Write-Verbose "Fetching Multiple Tax Regions"
        $TaxRegs = Invoke-ZomentumRequest -method get -resource "tax/regions" -Filters $Filters -MultiFetch
    }
    return $TaxRegs
  
}