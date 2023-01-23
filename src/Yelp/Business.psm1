function Search-YelpBusiness {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string []]
        $Categories
    )

    Invoke-YelpApi GET 'businesses/search' -Query @{
        location = Get-YelpLocation
        categories = $Categories -join ','
    } | Select-Object -ExpandProperty businesses | New-YelpObject 'Yelp.Business'
}

function Get-YelpBusiness {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
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
