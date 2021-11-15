function Get-ZomentumDocumentLines {
    <#
        .SYNOPSIS
            Gets Document line items from the Zomentum API.
        .DESCRIPTION
            Retrieves Documnet line itesm from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Product ID for retrieving a single client
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$DocumentID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$RevisionID
    )
  
    Write-Verbose "Fetching Line Items"
    $LinesRaw = Invoke-ZomentumRequest -method get -resource "documents/$DocumentID/revisions/$RevisionID/downloadproducts/" -RawResult
    $Lines = $LinesRaw.Content | convertfrom-csv
    return $Lines 
}