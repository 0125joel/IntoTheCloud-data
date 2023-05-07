#Try if Teams is installed and if so get content from the $ENV:APPDATA\Microsoft\Teams\desktop-config.json and get '"openAsHidden":false'#
$Folder = "$ENV:APPDATA\Microsoft\Teams"
$File = "$folder\desktop-config.json"
$Value = '"openAsHidden":false'
$newvalue = '"openAsHidden":true'

try {
     ############################################################################################
        #   CODE TO RUN ONCE

        # End active Teams process
        if(Get-Process Teams -ErrorAction SilentlyContinue){Get-Process Teams | Stop-Process -Force}
        # Replace/Set "openAsHidden" option to true
        (Get-Content $ENV:APPDATA\Microsoft\Teams\desktop-config.json -ErrorAction Stop).replace('"openAsHidden":false', '"openAsHidden":true') | Set-Content $ENV:APPDATA\Microsoft\Teams\desktop-config.json
        # STart Teams in background
        Start-Process -File $env:LOCALAPPDATA\Microsoft\Teams\Update.exe -ArgumentList '--processStart "Teams.exe" --process-start-args "--system-initiated"'

        #   END CODE TO RUN ONCE
        ############################################################################################
        $configfile = (Get-Content $File | Select-String -Pattern $newvalue).Matches.Success
        if ($configfile -contains $true) {
            Write-Warning "$newvalue is present"
            Exit 0
        }
        else {
            Write-Output "$newValue is not present"
            Exit 1
        }

        Write-Output "$Value is changed to $newvalue"


}
catch {
    {$_}
}