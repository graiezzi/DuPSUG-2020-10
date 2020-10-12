# Get the path of all the folders containing madules
$env:PSModulePath -split ';'

# How to install a module
# C:\Program Files\PowerShell\Modules
# C:\Program Files\WindowsPowerShell\Modules



# How to get the  commands available in a module
Get-Command -Module <module-name>

# How to use it in your scripts
Import-Module 