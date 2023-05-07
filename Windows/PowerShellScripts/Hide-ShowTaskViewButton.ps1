#Log specific variables#
$LogDir = "CustomLogs"
$logpath = "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs"
$logfolder = "$logpath\$LogDir"

#Registry values#
$RegistryPath = 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$RegistryName = 'ShowTaskViewButton'
$RegistryValue = '0'

Start-Transcript  -Path "$logfolder\Taskbar.txt" -append

#Create directory and file for logging#
if ((test-path $logfolder) -eq $false){
    new-item -Path $logpath -name $LogDir -ItemType "Directory"
}
else {
        Write-Output "The folder $LogDir already exists in $logpath"
}

#Function to test if a value in a key exists#
function Test-RegistryValue {

    param (

     [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Path,

    [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Value
    )

    try {

    Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
     return $true
     }

    catch {

    return $false
    }
}

#Test path#
if ((Test-RegistryValue -Path $RegistryPath -Value $RegistryName  ) -eq $false) {
    New-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $RegistryValue -PropertyType DWORD -ErrorAction Ignore
    Write-Output "$RegistryName is created in $RegistryPath"
}
else{
    Set-ItemProperty -Path $RegistryPath -Name $RegistryName -Value $RegistryValue -ErrorAction Ignore
    Write-Output "The value is changed to $RegistryValue on $RegistryName"
    }
Stop-Transcript