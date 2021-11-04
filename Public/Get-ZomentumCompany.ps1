function Get-ZomentumCompany {
    <#
        .SYNOPSIS
            Gets Your Root Company from the Zomentum API.
        .DESCRIPTION
            Retrieves Your Root Company from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    
    $Company = Invoke-ZomentumRequest -method get -resource "client/companies"
    
    return $Company.data
  
}