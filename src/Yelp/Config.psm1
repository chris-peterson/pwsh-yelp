if($PSVersionTable.Platform -like 'Win*') {
    $env:HOME = Join-Path $env:HOMEDRIVE $env:HOMEPATH
} 

$global:YelpConfigurationPath = Join-Path $env:HOME "/.config/powershell/yelp.config"

function Get-YelpLocation {
    param (
    )
    if (Test-Path $global:YelpConfigurationPath) {
        Get-Content $global:YelpConfigurationPath | ConvertFrom-Json | Select-Object -ExpandProperty Location
    } else {
        ''
    }
}

function Set-YelpLocation {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory)]
        [string]
        $Location
    )

    $CurrentLocation = Get-YelpLocation

    if ($PSCmdlet.ShouldProcess("Yelp Location", "Change from '$CurrentLocation' to '$Location'")) {
        @{
            Location = $Location
        } | ConvertTo-Json | Set-Content -Path $global:YelpConfigurationPath -Force | Out-Null
    }
}
