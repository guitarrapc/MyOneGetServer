param
(
    [string]$Server,
    [string]$NuGetPath
)

#Setup up the basics
$packageRoot = $PSScriptRoot # 現在のパスにパッケージ用の nuspec とか作る
$packageName = 'Adobe.CreativeCloud' #パッケージ名

New-Item -Path $packageRoot -item Directory -Force
New-Item -Path $packageRoot\$packageName -ItemType Directory -Force
New-Item -Path $packageRoot\$packageName\Tools -ItemType Directory -Force
 
#Define the package details
$packageTitle = 'Adobe Creative Cloud'
$packageVersion = "3.2.0.129" #バージョン
$packageSummary = 'Adobe Creative Cloud installation through OneGet'
$packageDescription = 'Adobe Creative Cloud installation through OneGet'
 
$packageAuthor = 'Adobe'
$packageOwner = 'Adobe'
$projectURL = 'https://creative.adobe.com'
$tags = 'Adobe'
 
$licenseURL = 'https://creative.adobe.com'
$requireLicenseAcceptance = 'false' #基本なしだろ
# $dependencies #依存があるなら。基本ないよね

# nuspec テンプレート
$nuspecFile = @"
<?xml version="1.0" encoding="utf-8"?>
<package xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <metadata>
    <id>$packageName</id>
    <title>$packageTitle</title>
    <version>$packageVersion</version>
    <authors>$packageAuthor</authors>
    <owners>$packageOwner</owners>
    <summary>$packageSummary </summary>
    <description>$packageDescription</description>
    <projectUrl>$projectURL</projectUrl>
    <tags>$tags</tags>
    <licenseUrl>$licenseURL</licenseUrl>
    <requireLicenseAcceptance>$requireLicenseAcceptance</requireLicenseAcceptance>
    <dependencies>
    </dependencies>
  </metadata>
</package>
"@
 
#create the nuspec file
try
{
    $sw = New-Object System.IO.StreamWriter ("$packageRoot\$packageName\$packageName.nuspec", $false);
    $sw.Write($nuspecFile);
}
finally
{
    $sw.Dispose();
}

# インストーラテンプレート
$installer = '
# Installer
$packageName = "CreativeCloudSet-Up"
$installerType = "exe"
$url = "https://ccmdls.adobe.com/AdobeProducts/KCCC/1/win32/CreativeCloudSet-Up.exe"
 
$silentArgs = "/quiet"
$validExitCodes = @(0)
 
Install-ChocolateyPackage "$packageName" "$installerType" -silentArgs "$silentArgs" "$url" -validExitCodes $validExitCodes
'

try
{
    $sw = New-Object System.IO.StreamWriter ("$packageRoot\$packageName\Tools\ChocolateyInstall.ps1", $false, [System.Text.Encoding]::UTF8);
    $sw.Write($installer);
}
finally
{
    $sw.Dispose();
}

# nuget pack
pushd (Split-Path $packageRoot -Parent)
. $NuGetPath pack "$packageRoot\$packageName\$packageName.nuspec"
popd