Install-Package -Source MyOneGet -Name Adobe.CreativeCloud

# あるいはパイプラインでつなげてもいい
Find-Package -Source MyOneget | where name -match Adobe | Install-Pacakge