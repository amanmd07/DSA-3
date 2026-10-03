Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host "   PROJECT FLOW: GRAPH ALGORITHMS & CRITICAL PATH METHOD (CPM) ENGINE" -ForegroundColor Cyan
Write-Host "===============================================================================" -ForegroundColor Cyan
Write-Host ""
Set-Location -Path "$PSScriptRoot\backend"
java -cp "bin;lib/*" com.projectscheduler.Main
Write-Host ""
