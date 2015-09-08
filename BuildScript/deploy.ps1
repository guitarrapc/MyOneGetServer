# sync "MyOneGetServer.Script" folder to wwwroot\MyOneGetServer.Script
$source = Join-Path (pwd).Path "MyOneGetServer.Script";
$destination = Join-Path $env:WEBROOT_PATH "MyOneGetServer.Script";

# create content path beforehand
if (-not (Test-Path $destination))
{
    mkdir -Path $destination -Force;
}

try
{
    # msdeploy can not be used. Use robocopy to sync folder
    . Robocopy.exe $source $destination /MIR /FFT /Z /XA:H /W:5
    exit 0
}
catch
{
    Write-Error $_
    exit 1
}