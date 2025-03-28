# Define a list of typical hidden settings along with their known GUIDs.
$typicalSettings = @(
    @{ Name = "Minimum Processor State"; GUID = "893dee8e-2bef-41e0-89c6-b55d0929964c" },
    @{ Name = "Maximum Processor State"; GUID = "bc5038f7-23e0-4960-96da-33abaf5935ec" },
    @{ Name = "System Cooling Policy"; GUID = "94d3a615-a899-4ac5-ae2b-e4d8f634367f" },
    @{ Name = "Sleep After"; GUID = "29f6c1db-86da-48c5-9fdb-f2b67b1f44da" },
    @{ Name = "Hibernate After"; GUID = "9d7815a6-7ee4-497e-8888-515a05f02364" },
    @{ Name = "Allow Hybrid Sleep"; GUID = "94ac6d29-73ce-41a6-8098-6363ba21b47e" },
    @{ Name = "Turn Off Hard Disk After"; GUID = "6738e2c4-e8a5-4a42-b16a-e040e769756e" },
    @{ Name = "Turn Off Display After"; GUID = "3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e" },
    @{ Name = "USB Selective Suspend"; GUID = "2a737441-1930-4402-8d77-b2bebba308a3" },
    @{ Name = "PCI Express Link State Power Management"; GUID = "ded574b5-45a0-4f42-8a3a-74b0f14a3d4d" },
    @{ Name = "Wireless Adapter Power Saving Mode"; GUID = "501a4d13-42af-4429-9fd1-a8218c268e20" }
)

# Get all the power plan GUIDs (extract only the GUID portion).
$powerSchemes = powercfg /list | Select-String -Pattern 'Power Scheme GUID: ([0-9a-fA-F-]+)' | ForEach-Object { $_.Matches[0].Groups[1].Value }

foreach ($scheme in $powerSchemes) {
    Write-Host "Processing power plan: ${scheme}"
    
    foreach ($setting in $typicalSettings) {
        $name = $setting.Name
        $guid = $setting.GUID
        
        Write-Host "Checking $name ($guid)..."
        
        # Query the specific setting in the current power plan.
        $queryOutput = powercfg /query ${scheme} ${guid} 2>&1
        
        if ($queryOutput -match "Invalid") {
            Write-Host "  $name is not applicable or not found in this power plan."
        }
        else {
            if ($queryOutput -match "Hidden") {
                Write-Host "  $name ($guid) was hidden. Unhiding..."
                powercfg /change ${guid} /visible
                Write-Host "  $name ($guid) is now unhidden."
            }
            else {
                Write-Host "  $name ($guid) is already visible."
            }
        }
    }
    Write-Host ""  # Blank line for separation between power plans.
}

Write-Host "All typical hidden power plan settings have been processed."
