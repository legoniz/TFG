# Get-AD info

# obtiene el número de estación de trabajo dadas de alta en AD
$Computers = (Get-ADComputer -Filter *).count
$Workstations = (Get-ADComputer -LDAPFilter "(&(objectClass=Computer) (!operatingSystem=*server*))" -Searchbase (Get-ADDomain).distinguishedName).count

# obtiene el número de servidores dados de alta en AD
$Servers = (Get-ADComputer -LDAPFilter "(&(objectClass=Computer) (operatingSystem=*server*))" -Searchbase (Get-ADDomain).distinguishedName).count

# obtiene el número de usuarios dados de alta en AD
$Users = (Get-ADUser -Filter *).count 

# obtiene el número de grupos de seguridad dadas de alta en AD
$Groups = (Get-ADGroup -Filter *).Count

# para obtener resto de variables que identifican la estructura del bosque y dominio
$ADForest = (Get-ADDomain).Forest
$FSMO = netdom query FSMO
$ADForestMode = (Get-ADForest).ForestMode
$ADDomainMode = (Get-ADDomain).DomainMode
$ADVer = Get-ADObject (Get-ADRootDSE).schemaNamingContext -property objectVersion | Select objectVersion
$ADNUM = $ADVer -replace "@{objectVersion=", "" -replace "}", ""

# para obtener la versión del SO de cada servidor encontrado
If ($ADNum -eq '88') { $srv = 'Windows Server 2019/Windows Server 2022' }
ElseIf ($ADNum -eq '87') { $srv = 'Windows Server 2016' }
ElseIf ($ADNum -eq '69') { $srv = 'Windows Server 2012 R2' }
ElseIf ($ADNum -eq '56') { $srv = 'Windows Server 2012' }
ElseIf ($ADNum -eq '47') { $srv = 'Windows Server 2008 R2' }
ElseIf ($ADNum -eq '44') { $srv = 'Windows Server 2008' }
ElseIf ($ADNum -eq '31') { $srv = 'Windows Server 2003 R2' }
ElseIf ($ADNum -eq '30') { $srv = 'Windows Server 2003' }

# Se diferencian los objetos por colores mostrados por pantalla
Write-host "Active Directory Info" -ForegroundColor Yellow
Write-host ""
Write-Host "Workstions =   "$Workstations -ForegroundColor Cyan
Write-Host "Servers =      "$Servers -ForegroundColor Cyan
Write-Host "Users =        "$Users -ForegroundColor Cyan
Write-Host "Groups =       "$Groups -ForegroundColor Cyan
Write-host ""
Write-Host "Active Directory Forest Name =  "$ADForest -ForegroundColor Cyan
Write-Host "Active Directory Forest Mode =  "$ADForestMode -ForegroundColor Cyan
Write-Host "Active Directory Domain Mode =  "$ADDomainMode -ForegroundColor Cyan
Write-Host "Active Directory Schema Version is $ADNum which corresponds to $Srv" -ForegroundColor Cyan
Write-Host ""
Write-Host "FSMO Role Owners" -ForegroundColor Cyan
$FSMO
