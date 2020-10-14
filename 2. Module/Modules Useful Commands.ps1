
# 1- Create a new folder and a file in it with extention .psm1, both having the same name
New-Item -Path 'C:\Users\grazi\DuPSUG-2020-10\2. Module\MyModule' -ItemType Directory -Force
New-Item -Path 'C:\Users\grazi\DuPSUG-2020-10\2. Module\MyModule\MyModule.psm1' -ItemType File -Force

# 2- Write your script

# How and where to install a module

# 1- Get the path of all the folders containing madules
$env:PSModulePath -split ';'
# 2- Check if the folder exist if not create a new one - This will only run as Administrator
$modulesFolder = 'C:\Program Files\PowerShell\Modules'
if (-not (Test-Path $modulesFolder)){
    New-Item -Path $modulesFolder -ItemType Directory
} 
# 3- Copy the folder of your module in the Module folder
$sourcePath = 'C:\Users\grazi\DuPSUG-2020-10\2. Module\MyModule'
Copy-Item -Path $sourcePath -Destination $modulesFolder -Recurse
Get-ChildItem -Path $modulesFolder

# How to find a module
Get-Module -ListAvailable

# How to get the  commands available in a module
Get-Command -Module MyModule 

# How to use it in your scripts
Import-Module MyModule
# Just call the function you need...
Get-RestMethodResultsCursorPaged -Credential $cred 
