function Invoke-ZomentumRequest {
	[CmdletBinding()]
	Param(
		[string]$Method,
		[string]$Resource,
		[string]$Body,
		$Filters,
		[switch]$MultiFetch,
		[string]$QueryString,
		[switch]$RawResult
	)

	$ProgressPreference = 'SilentlyContinue'
	
	if (!$Script:ZomentumAccessToken) {
		Throw "Not connected to Zomentum please run Connect-Zomentum first"
	}

	$headers = @{
		Authorization = "Bearer $($Script:ZomentumAccessToken)"
	}

	$ResourceFilter = ''

	if ($Filters) {
		#$ExampleFilters = @(
		#	@{
		#		field    = "phone"
		#		operator = "eq"
		#		value    = "1234566789"
		#	},
		#	@{
		#		field    = "outcome"
		#		operator = "eq"
		#		value    = "connected"
		#	}
		#)

		Write-Verbose "Generating Filter"

		$ResourceFilter = foreach ($Filter in $Filters) {
			"$($Filter.field):$($Filter.operator):$($Filter.value);"		
		}

		$ResourceFilter = $ResourceFilter -join ("")

		$ResourceFilter = "&filters=$ResourceFilter"
	}



	try {
		if (($Method -eq "put") -or ($Method -eq "post") -or ($Method -eq "delete")) {
			$Response = Invoke-WebRequest -method $method -uri ($Script:ZomentumBaseURL + $Resource) -ContentType 'application/json' -body $Body -Headers $headers -ea stop
			$Result = $Response | ConvertFrom-Json -depth 100
		} else {
			if (!$MultiFetch) {
				Write-Verbose "Using single fetch"
				$Response = Invoke-WebRequest -method $method -uri ($Script:ZomentumBaseURL + $Resource + $ResourceFilter) -Headers $headers -ea stop
				if ($RawResult) {
					$Result = $Response
				} else {
					$Result = $Response.Content | ConvertFrom-Json -Depth 100
				}
				
			} else {
				$PageNo = 1
				$Result = do {
					$URI = ($Script:ZomentumBaseURL + $Resource + "?count_query_flag=true&page=$PageNo&limit=$Script:ZomentumAPILimit" + $ResourceFilter + $QueryString)
					Write-Verbose "Fetching Page: $PageNo - URI: $URI"
					$Response = Invoke-WebRequest -method $method -uri $URI -Headers $headers -ea stop
					Write-Verbose "Response: $($Response | Format-List | Out-String)"
					Write-Debug "Content: $($Response.Content | Format-List | Out-String)"
					$PartResult = $Response.content | ConvertFrom-Json -Depth 100
					$PageTotal = [Math]::Round([Math]::Ceiling($PartResult.filtered_count_map.all / $Script:ZomentumAPILimit))
					Write-Verbose "PageTotal calcualted to $PageTotal"
					$PageNo++
					$PartResult.Data					
				} while ($PageNo -le $PageTotal)
			}
		}
	} catch {

		Write-Error "An Error Occured $($_) "
	}
	
	return $Result
	
}