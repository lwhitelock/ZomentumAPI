function Get-ZomentumPipelines {
     <#
        .SYNOPSIS
            Gets Pipelines from the Zomentum API.
        .DESCRIPTION
            Retrieves Pipelines from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Pipeline ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$PipelineID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters
    )
  
    if ($PipelineID) {
        Write-Verbose "Fetching Single Pipeline"
        $Pipelines = Invoke-ZomentumRequest -method get -resource "pipelines/$PipelineID"
    } else {
        Write-Verbose "Fetching Multiple Pipelines"
        $Pipelines = Invoke-ZomentumRequest -method get -resource "pipelines" -Filters $Filters -MultiFetch
    }
    return $Pipelines
  
}