# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# OpenSSH がインストールされたか確認
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'