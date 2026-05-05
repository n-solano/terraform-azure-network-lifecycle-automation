# Azure Free Tier Network Lab - Destroy Script
Write-Host "========================================" -ForegroundColor Magenta
Write-Host " Destroy Network Lab Resources" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

$confirm = Read-Host "This will destroy ALL resources. Type 'DELETE' to confirm"
if ($confirm -eq 'DELETE') {
    Write-Host "`nDestroying resources..." -ForegroundColor Red
    terraform destroy -auto-approve
    
    Write-Host "`nAll resources destroyed." -ForegroundColor Green
} else {
    Write-Host "Destruction cancelled." -ForegroundColor Yellow
}
