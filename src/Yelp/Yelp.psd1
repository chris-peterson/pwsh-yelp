@{
    ModuleVersion = '0.0.1'

    PrivateData = @{
        PSData = @{
            LicenseUri = 'https://github.com/chris-peterson/pwsh-yelp/blob/main/LICENSE'
            ProjectUri = 'https://github.com/chris-peterson/pwsh-yelp'
            ReleaseNotes = 'initial revision'
        }
    }

    GUID = 'b4d6d494-95b9-434e-8255-a428e077c9fb'

    Author = 'Chris Peterson'
    CompanyName = 'Chris Peterson'
    Copyright = '(c) 2023'

    Description = 'Interact with Yelp via PowerShell'
    PowerShellVersion = '7.1'

    ScriptsToProcess = @()
    TypesToProcess = @('Types.ps1xml')
    FormatsToProcess = @('Formats.ps1xml')

    NestedModules = @(
        'Business.psm1',
        'Utilities.psm1'
    )
    FunctionsToExport = @(
        # Business
        'Get-YelpHours'

        # Utilities
        'New-YelpObject'
    )
    AliasesToExport = @(
    )
}
