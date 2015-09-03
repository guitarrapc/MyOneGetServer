
# Installer
$packageName = "CreativeCloudSet-Up"
$installerType = "exe"
$url = "https://ccmdls.adobe.com/AdobeProducts/KCCC/1/win32/CreativeCloudSet-Up.exe"
 
$silentArgs = "/quiet"
$validExitCodes = @(0)
 
Install-ChocolateyPackage "$packageName" "$installerType" -silentArgs "$silentArgs" "$url" -validExitCodes $validExitCodes
