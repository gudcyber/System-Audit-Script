# System Audit Script

This PowerShell script audits a Windows machine and outputs a clean, structured report. It captures essential data needed for IT Support, Help Desk, and System Analyst tasks.

## What It Does

The script checks:

- OS version and system info
- CPU, RAM, and storage details
- Active network adapters and IPs
- Running processes and memory usage
- System uptime
- Installed antivirus
- Logged-in user and environment variables

## Output

The report is saved to `System_Audit_Report.txt`. It’s readable and organized for fast troubleshooting or documentation.

## How to Use

1. Open PowerShell as Administrator.
2. Run the script:
   ```powershell
   .\system_audit.ps1
