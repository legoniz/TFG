# Get-AD info
# obtiene el número total de equipos (incluye equipos clientes y servidores) dadas de alta en AD

$Computers = (Get-ADComputer -Filter *).count

# obtiene el número de equipos (sin incluir servidores) dadas de alta en AD
$Workstations = (Get-ADComputer -LDAPFilter "(&(objectClass=Computer) (!operatingSystem=*server*))" -Searchbase (Get-ADDomain).distinguishedName).count

# obtiene el número de servidores dados de alta en AD
$Servers = (Get-ADComputer -LDAPFilter "(&(objectClass=Computer) (operatingSystem=*server*))" -Searchbase (Get-ADDomain).distinguishedName).count

# obtiene el número total de usuarios dados de alta en AD
$Users = (Get-ADUser -Filter *).count 

# obtiene el número total de grupos de seguridad dadas de alta en AD
$Groups = (Get-ADGroup -Filter *).Count

# para obtener resto de variables que identifican la estructura del bosque y dominio
# obtener el dominio del bosque
$ADForest = (Get-ADDomain).Forest

# obtener los FSMO – Flexible Single Master Operations. Usadas principalmente para la replicación entre controladores de dominio
$FSMO = netdom query FSMO

# obtener el nivel funcional del bosque y del dominio (determina las funcionalidades disponibles del bosque. Mas detalle en https://learn.microsoft.com/es-es/windows-server/identity/ad-ds/active-directory-functional-levels)
$ADForestMode = (Get-ADForest).ForestMode
$ADDomainMode = (Get-ADDomain).DomainMode

# Se diferencian los objetos por colores mostrados por pantalla
Write-host "Active Directory Info" -ForegroundColor Yellow
Write-host ""
Write-Host "Workstions = "$Workstations -ForegroundColor Cyan
Write-Host "Servers = "$Servers -ForegroundColor Cyan
Write-Host "Users = "$Users -ForegroundColor Cyan
Write-Host "Groups = "$Groups -ForegroundColor Cyan
Write-host ""
Write-Host "Active Directory Forest Name = "$ADForest -ForegroundColor Cyan
Write-Host "Active Directory Forest Mode = "$ADForestMode -ForegroundColor Cyan
Write-Host "Active Directory Domain Mode = "$ADDomainMode -ForegroundColor Cyan
Write-Host ""
Write-Host "FSMO Role Owners" -ForegroundColor Cyan

$FSMO
