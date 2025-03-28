
# PowerPlanUnhide

This repository contains a PowerShell script to unhide hidden power plan settings in Windows. The script reveals typically hidden settings that can impact system power behavior, such as processor power management, sleep settings, and more.

## Usage

To quickly run the script directly from this repository, you can execute the following single command in PowerShell.

### Steps to run the script:

1. Open **PowerShell as Administrator**.
2. Execute the following command to download and run the script:

```powershell
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/<your-username>/PowerPlanUnhide/main/unhide.ps1'))
```

This will download the script and run it in one go. The script will automatically check and unhide any hidden power plan settings.

### What the script does:
- Loops through all power plans on your system.
- Checks typical hidden settings and unhides them if necessary.
- Provides output for each setting, indicating if it was hidden and now unhidden.

## Warning

**Use this script at your own risk.**  
By executing this script, you are taking responsibility for any changes it makes to your system’s power plan settings. While the script is designed to unhide typical power settings that could enhance your control over your PC's power behavior, it is crucial that you are deliberate and careful about the changes you make. Incorrect power plan settings can affect your system’s stability and performance.

Always review and understand scripts before running them, especially when executing scripts from the internet. It is recommended to test in a controlled environment before applying it to critical systems.

## Notes
- Ensure you have **Administrator** privileges to execute the script.
- This script is designed to work on Windows systems only.
