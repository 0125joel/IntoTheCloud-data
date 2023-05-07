#Try if Teams is installed and if so get content from the $ENV:APPDATA\Microsoft\Teams\desktop-config.json and get '"openAsHidden":false'#
$Application = "Teams"
$Folder = "$ENV:APPDATA\Microsoft\Teams"
$File = "$folder\desktop-config.json"
$Value = '"openAsHidden":false'

if ((Test-Path -Path $env:LOCALAPPDATA\Microsoft\Teams\Update.exe) -eq $true) {
    try{

        $configfile = (Get-Content $File | Select-String -Pattern $Value).Matches.Success
        if ($configfile -contains $true) {
            Write-Warning "$Value is present"
            Exit 1
        }
        else {
            Write-Output "$Value is not present"
            Exit 0
        }

    }catch{$_}
}
else {
    Write-Output "$Application is not installed yet."
}
