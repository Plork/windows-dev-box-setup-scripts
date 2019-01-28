# Description: Boxstarter Script
# Author: Microsoft
# Common settings for azure devops

Disable-UAC
$ConfirmPreference = "None" #ensure installing powershell modules don't prompt on needed dependencies

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "SystemConfiguration.ps1";
executeScript "CommonDevTools.ps1";

executeScript "Docker.ps1";

choco install -y powershell-core
choco install -y azure-cli
Install-Module -Force Az
choco install -y microsoftazurestorageexplorer

choco install -y visualstudio2017community
choco install -y visualstudio2017-workload-azure
Update-SessionEnvironment #refreshing env due to Git install

choco install -y wsl
choco install -y dashlane
choco install -y vitualbox
choco install -y git-credential-winstore
choco install -y poshgit
choco install -y postman
choco install -y vagrant
choco install -y conemu
choco install -y slack
choco install -y microsoft-teams
choco istalll -y whatsapp

choco install -y visualstudiocode
choco install vscode-powershell
choco install vscode-docker
choco install vscode-gitlens
choco install vscode-editorconfig 


# Install tools in WSL instance
write-host "Installing tools inside the WSL distro..."
Ubuntu1804 run apt install ansible -y
Ubuntu1804 run apt install python2.7 python-pip -y 
Ubuntu1804 run curl -L https://omnitruck.chef.io/install.sh | sudo bash

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
