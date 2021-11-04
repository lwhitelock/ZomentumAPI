$Public  = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue) + @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
foreach ($import in @($Public)){
    try
    {
        . $import.FullName
    }
    catch
    {
        Write-Error -Message "Failed to import function $($import.FullName): $_"
    }
}
$Script:ZomentumBaseURL = 'https://api.zomentum.com/v2/'
$Script:ZomentumAPILimit = 1000
Export-ModuleMember -Function $Public.BaseName -Alias *