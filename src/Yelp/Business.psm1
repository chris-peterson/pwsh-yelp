function Search-YelpBusiness {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $Term,

        [Parameter()]
        [string []]
        $Categories = @(),

        [Parameter()]
        [ValidateSet('$', '$$', '$$$', '$$$$')]
        [string]
        $PriceLevel,

        [Parameter()]
        [switch]
        $OpenNow,

        [Parameter()]
        [DateTime]
        $OpenAt,

        [switch]
        [Parameter()]
        $Enrich
    )

    $Query = @{
        location   = Get-YelpLocation
        categories = $Categories -join ','
        term       = $Term
    }
    if ($PriceLevel) {
        $PriceLevels = @()
        $NumDollars = $PriceLevel.Length
        for ($i = 1; $i -le $NumDollars; $i++) {
            $PriceLevels += $i
        }
        $Query.price = $PriceLevels -join ','
    }
    if ($OpenNow) {
        $Query.open_now = 'true'
    }
    elseif ($OpenAt) {
        $UnixEpoch = Get-Date '1970-01-01'
        $Timestamp = [Math]::Round($($OpenAt - $UnixEpoch).TotalSeconds)
        $Query.open_at = $Timestamp
    }

    $Result = Invoke-YelpApi GET 'businesses/search' -Query $Query |
        Select-Object -ExpandProperty businesses

    if ($Enrich) {
        $Result | ForEach-Object {
            Get-YelpBusiness $_.id
        }
    } else {
        $Result | New-YelpObject 'Yelp.Business'
    }
}

function Get-YelpBusiness {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]
        $Id,

        [Parameter()]
        [string]
        $Select
    )

    $Business = Invoke-YelpApi GET "businesses/$Id" | New-YelpObject 'Yelp.Business'
    $Business | Add-Member -NotePropertyName 'OpenTime' -NotePropertyValue $($Business.Hours.open | New-YelpObject 'Yelp.OpenTime')
    $Business | Get-FilteredYelpObject $Select
}
