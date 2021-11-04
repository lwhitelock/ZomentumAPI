function Get-ZomentumOpportunities {
     <#
        .SYNOPSIS
            Gets Opportunities from the Zomentum API.
        .DESCRIPTION
            Retrieves Opportunities from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Opportunity ID for retrieving a single Opportunity
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$OpportunityID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters,
        # The pipeline for which opportunities will be fetched. If no argument is passed the default pipline will be used.
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$PipelineID
    )
  
    if ($OpportunityID) {
        Write-Verbose "Fetching Single Opportunities"
        $Opportunities = Invoke-ZomentumRequest -method get -resource "opportunities/$OpportunityID"
    } else {
        $QueryString = ''
        if ($PipelineID){
            $QueryString = "&opportunity_pipeline_id=$PipelineID"
        }
        Write-Verbose "Fetching Multiple Opportunities"
        $Opportunities = Invoke-ZomentumRequest -method get -resource "opportunities" -Filters $Filters -MultiFetch -QueryString $QueryString
    }
    return $Opportunities
  
}