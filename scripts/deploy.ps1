# Azure Free Tier Network Lab - Deployment Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Azure Free Tier Network Lab Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check Azure CLI
if (-not (Get-Command "az" -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Azure CLI not found. Please install from https://aka.ms/installazurecliwindows" -ForegroundColor Red
    exit 1
}

# Check Terraform
if (-not (Get-Command "terraform" -ErrorAction SilentlyContinue)) {
    Write-Host "[ERROR] Terraform not found. Please install from https://www.terraform.io/downloads" -ForegroundColor Red
    exit 1
}

Write-Host "[1/5] Logging into Azure..." -ForegroundColor Yellow
az login --use-device-code
az account show

Write-Host "`n[2/5] Initializing Terraform..." -ForegroundColor Yellow
terraform init

Write-Host "`n[3/5] Validating configuration..." -ForegroundColor Yellow
terraform validate

Write-Host "`n[4/5] Previewing changes..." -ForegroundColor Yellow
terraform plan -out=tfplan

Write-Host "`n[5/5] Deploying infrastructure..." -ForegroundColor Yellow
$confirm = Read-Host "Proceed with deployment? (y/n)"
if ($confirm -eq 'y') {
    terraform apply tfplan
    
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host " Deployment Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Resources deployed with ZERO cost." -ForegroundColor Green
    Write-Host "All networking services are in Azure free tier." -ForegroundColor Green
    Write-Host ""
    
    terraform output
    
    Write-Host ""
    Write-Host "To destroy: .\scripts\destroy.ps1" -ForegroundColor Yellow
} else {
    Write-Host "Deployment cancelled." -ForegroundColor Red
}
