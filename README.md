# 🆓 Azure Free Tier Network Lab

A production-style Azure network environment built entirely with **free tier services**. Demonstrates enterprise networking patterns with zero cost.

Zero Cost Guarantee
All resources in this lab are from Azure's always free or free tier services:

Virtual Networks: Always free (up to 50)

Network Security Groups: Always free

Network Watcher: Base features free

Log Analytics: 5GB/month free

Activity Log Alerts: Free

📊 Monitoring Features
NSG Rule Changes - Instant alert when security rules are modified

VNet Changes - Alert on any network configuration modifications

Network Watcher - Built-in diagnostics and troubleshooting

Log Analytics - Centralized logging with KQL query support


## 🎯 What This Builds

| Resource | Purpose | Cost |
|----------|---------|------|
| Virtual Network (VNet) | Network isolation | **FREE** |
| 4 Subnets | Tiered architecture (Web/App/Data/Mgmt) | **FREE** |
| Network Security Group | Traffic filtering | **FREE** |
| Network Watcher | Network diagnostics | **FREE** |
| Log Analytics Workspace | Centralized monitoring | **FREE** (5GB/month) |
| Activity Log Alerts | Change monitoring | **FREE** |

This project focuses on free-tier networking only:
- Virtual Network, Subnets, NSG, and Network Watcher
- No VMs or Web Apps are provisioned

## 📐 Architecture

┌──────────────────────────────────────────┐
│ Virtual Network (10.1.0.0/16) │
│ │
│ ┌──────────┐ ┌──────────┐ │
│ │ Web Tier │ │ App Tier │ │
│ │10.1.1.0 │ │10.1.2.0 │ │
│ └──────────┘ └──────────┘ │
│ │
│ ┌──────────┐ ┌──────────┐ │
│ │Data Tier │ │ Mgmt Tier│ │
│ │10.1.3.0 │ │10.1.4.0 │ │
│ └──────────┘ └──────────┘ │
│ │
│ ┌──────────────────┐ │
│ │ NSG (Deny │ │
│ │ All Inbound) │ │
│ └──────────────────┘ │
└──────────────────────────────────────────┘

Monitoring:
├── Network Watcher (Diagnostics)
├── Log Analytics (Centralized Logs)
└── Activity Alerts (Change Detection)


Project Structure:
├── main.tf              # Root configuration
├── variables.tf          # Input variables
├── outputs.tf            # Output values
├── providers.tf          # Provider configuration
├── modules/
│   ├── network/          # Network module
│   │   ├── main.tf       # VNet, Subnets, NSG
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── monitoring/       # Monitoring module
│       ├── main.tf       # Log Analytics, Alerts
│       ├── variables.tf
│       └── outputs.tf
└── scripts/
    ├── deploy.ps1        # Deployment script
    └── destroy.ps1       # Cleanup script


## 🚀 Quick Start

### Prerequisites
- [Azure CLI](https://aka.ms/installazurecliwindows)
- [Terraform](https://www.terraform.io/downloads) >= 1.5.0
- Azure free account

### Deploy

```powershell
# Option 1: Using the script
.\scripts\deploy.ps1

# Option 2: Manual
terraform init
terraform plan -out=tfplan
terraform apply tfplan
