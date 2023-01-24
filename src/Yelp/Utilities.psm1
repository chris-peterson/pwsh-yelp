function Invoke-YelpApi {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Position=0, Mandatory)]
        [string]
        $Method,

        [Parameter(Position=1, Mandatory)]
        [string]
        $Resource,

        [Parameter()]
        [hashtable]
        $Query = @{},

        [Parameter(Mandatory=$false)]
        [hashtable]
        $Body = @{}
    )

    $SerializedQuery = ''
    $Delimiter = '?'
    if($Query.Count -gt 0) {
        foreach($Name in $Query.Keys) {
            $Value = $Query[$Name]
            if ($Value) {
                $SerializedQuery += $Delimiter
                $SerializedQuery += "$Name="
                $SerializedQuery += [System.Net.WebUtility]::UrlEncode($Value)
                $Delimiter = '&'
            }
        }
    }

    $Uri = "https://api.yelp.com/v3/$Resource$SerializedQuery"

    if ($PSCmdlet.ShouldProcess("$Resource$SerializedQuery", "$Method")) {
        Invoke-RestMethod -Headers @{ 'Authorization' = "Bearer $env:YELP_API_SECRET" } `
            -Method $Method -Uri $Uri -Body $Body
    }
}

# Inspired by https://gist.github.com/awakecoding/acc626741704e8885da8892b0ac6ce64
function ConvertTo-PascalCase
{
    param(
        [Parameter(Position=0, ValueFromPipeline=$true)]
        [string] $Value
    )

    # https://devblogs.microsoft.com/oldnewthing/20190909-00/?p=102844
    return [regex]::replace($Value.ToLower(), '(^|_)(.)', { $args[0].Groups[2].Value.ToUpper()})
}

function Get-FilteredYelpObject {
    param (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        $InputObject,

        [Parameter(Position=0, Mandatory=$false)]
        [string]
        $Select = '*'
    )
    Begin {}
    Process {
        foreach ($Object in $InputObject) {
            if (($Select -eq '*') -or (-not $Select)) {
                $Object
            } elseif ($Select.Contains(',')) {
                $Object | Select-Object $($Select -split ',')
            } else {
                $Object | Select-Object -ExpandProperty $Select
            }
        }
    }
    End {}
}

function New-YelpObject {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        $InputObject,

        [Parameter(Position=0, Mandatory=$false)]
        [string]
        $DisplayType
    )
    process {
        foreach ($Item in $InputObject) {
            $Wrapper = New-Object PSObject
            $item.PSObject.Properties |
                Sort-Object Name |
                ForEach-Object {
                    $Wrapper | Add-Member -MemberType NoteProperty -Name $($_.Name | ConvertTo-PascalCase) -Value $_.Value
                }
            if ($DisplayType) {
                $Wrapper.PSTypeNames.Insert(0, $DisplayType)
            }
            Write-Output $Wrapper
        }
    }
}
