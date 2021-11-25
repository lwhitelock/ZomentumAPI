function Get-ZomentumDocuments {
    <#
        .SYNOPSIS
            Gets Documents from the Zomentum API.
        .DESCRIPTION
            Retrieves Documents from the Zomentum API - supports a variety of filtering parameters.
        .OUTPUTS
            A powershell object containing the response.
    #>
    [CmdletBinding()]
    Param(
        # Document ID for retrieving a single Document
        [Parameter( ParameterSetName = 'SingleFile', Mandatory = $True )]
        [Parameter( ParameterSetName = 'SinglePath', Mandatory = $True )]
        [Parameter( ParameterSetName = 'Single', Mandatory = $True )]
        [string]$DocumentID,
        # An Object containing filter variables
        [Parameter( ParameterSetName = 'Multiple')]
        [PSCustomObject]$Filters,
        # The Child entities to include with the records.
        [Parameter( ParameterSetName = 'Single' )]
        [Parameter( ParameterSetName = 'Multiple')]
        [string]$IncludeChildren,
        # Use the alternate API endpoint
        [Parameter( ParameterSetName = 'Single')]
        [Parameter( ParameterSetName = 'Multiple')]
        [switch]$AlternateEndpoint,
        # Allow Writing Directly to File, using the specified path and file name eg c:\temp\myfile.txt
        [Parameter( ParameterSetName = 'SingleFile', Mandatory = $True )]
        [String]$OutFile,
        # Allow Writing Directly to File, using the specified path and the original file name eg c:\temp\
        [Parameter( ParameterSetName = 'SinglePath', Mandatory = $True )]
        [String]$OutPath
    )
          
    if ($DocumentID -and !$AlternateEndpoint) {
        Write-Verbose "Fetching Document"
        $DocumentResult = Invoke-ZomentumRequest -method get -resource "documents/download/$DocumentID" -RawResult
        Write-Verbose 'Processing Processing Document'
        if ($OutFile -or $OutPath) {
            # Get the file name or set it
            if ($OutPath) {
                Write-Verbose "Attempting to output to path $OutPath"
                $ContentDisposition = $DocumentResult.Headers.'Content-Disposition'
                $Disposition = [System.Net.Mime.ContentDisposition]::new($ContentDisposition)
                $FileName = $Disposition.FileName
                $Path = Join-Path $OutPath $FileName
            } else {
                Write-Verbose "Attempting to output to file $OutFile"
                $Path = $OutFile
            }

            Write-Verbose "Writing File $Path"
            $File = [System.IO.FileStream]::new($Path, [System.IO.FileMode]::Create)
            $File.write($DocumentResult.Content, 0, $DocumentResult.RawContentLength)
            $File.close()
        } else {
            return $DocumentResult.Content
        }
    } else {
        $QueryString = ''
        
        if ($AlternateEndpoint) {
            if ($DocumentID){
                if ($IncludeChildren) {
                    $QueryString = $QueryString + "?included_child_entities=$IncludeChildren"
                }
                Write-Verbose "Fetching Alternate Single Document Metadata"
                $Documents = Invoke-ZomentumRequest -method get -resource "documents/$DocumentID" -QueryString $QueryString

            } else {
                if ($IncludeChildren) {
                    $QueryString = $QueryString + "&included_child_entities=$IncludeChildren"
                }
                Write-Verbose "Fetching Alternate All Document Metadata"
                $Documents = Invoke-ZomentumRequest -method get -resource "documents" -Filters $Filters -MultiFetch -QueryString $QueryString
            }
        } else {
            if ($IncludeChildren) {
                $QueryString = $QueryString + "&included_child_entities=$IncludeChildren"
            }
            Write-Verbose "Fetching All Document Metadata"
            $Documents = Invoke-ZomentumRequest -method get -resource "documents/zapier" -Filters $Filters -MultiFetch -QueryString $QueryString
        }
        return $Documents
    }
    
  
}
