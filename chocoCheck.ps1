# Load the required assembly for Windows notifications
Add-Type -AssemblyName System.Windows.Forms

# Function to display a Windows notification
function Show-WindowsNotification {
    param (
        [string]$Title,
        [string]$Message
    )

    $notification = New-Object System.Windows.Forms.NotifyIcon
    $notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
    $notification.BalloonTipTitle = $Title
    $notification.BalloonTipText = $Message
    $notification.Visible = $true
    $notification.ShowBalloonTip(5000)
}

# Check for outdated Chocolatey packages
$chocoOutdated = choco outdated | Select-String -Pattern "\bYou have\b"

if ($chocoOutdated) {
    $outdatedPackages = $chocoOutdated -replace ".*You have (\d+) .*","\1"
    $notificationTitle = "Chocolatey Outdated Packages"
    $notificationMessage = "$outdatedPackages outdated package(s) found. Run 'choco upgrade all' to update."
    
    # Display the Windows notification
    Show-WindowsNotification -Title $notificationTitle -Message $notificationMessage
}