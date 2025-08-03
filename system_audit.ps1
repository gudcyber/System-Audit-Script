# System Audit Script

$report = @{}

# OS Info
$report["OS"] = Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber

# CPU and RAM
$report["CPU"] = Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, MaxClockSpeed
$report["RAM (GB)"] = [math]::round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)

# Disk Usage
$report["Drives"] = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free, @{Name="Used(GB)";Expression={[math]::round($_.Used/1GB,2)}}, @{Name="Free(GB)";Expression={[math]::round($_.Free/1GB,2)}}

# Running Processes
$report["Top Processes"] = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU

# Network Info
$report["Hostname"] = $env:COMPUTERNAME
$report["IP"] = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -notlike "169.*"} | Select-Object -First 1 IPAddress).IPAddress

# Antivirus
$report["Antivirus"] = Get-CimInstance -Namespace "root/SecurityCenter2" -ClassName "AntiVirusProduct" | Select-Object displayName, pathToSignedProductExe, productState

# Output
$report | Out-File -FilePath "$env:USERPROFILE\Desktop\System_Audit_Report.txt"
Write-Host "Audit complete. Report saved to Desktop."
