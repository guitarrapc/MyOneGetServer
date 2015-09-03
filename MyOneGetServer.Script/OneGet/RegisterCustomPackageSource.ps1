# Get-PackageSource で Chocolatey の登録がされてない場合
Register-PackageSource -Name chocolatey -Provider PSModule -Trusted -Location http://chocolatey.org/api/v2/

# MyOneGet の登録
Register-PackageSource -Name MyOneGet -Location http://localhost:33478/nuget -Trusted -Force -ProviderName chocolatey