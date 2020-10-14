$path = 'C:\Users\grazi\DuPSUG-2020-10\3. Transcript'

Start-Transcript -Path "$path\log.txt"

Get-ChildItem -Path "$path\ABC"
$a = 1

Write-Host "This is a: $a"

Stop-Transcript