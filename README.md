[![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?logo=terraform)](https://www.terraform.io)
[![Azure](https://img.shields.io/badge/Azure-Production-0078D4?logo=microsoft-azure)](https://azure.microsoft.com)
[![Monitoring](https://img.shields.io/badge/Monitoring-Active-4CAF50?logo=prometheus)](https://prometheus.io)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=github-actions)](https://github.com/features/actions)

# Terraform Azure Networking with Monitoring

This project provides a comprehensive Azure networking infrastructure solution with built-in monitoring, maintenance, and change detection capabilities.

## Features

- **Automated Network Deployment**: Full Azure VNet with customizable subnets
- **Network Security**: NSG configuration and management
- **Comprehensive Monitoring**: 
  - Network Watcher integration
  - Flow logs and traffic analytics
  - Connection monitoring
  - DNS resolution tracking
- **Alerting System**: 
  - Configuration change alerts
  - Connectivity issue alerts
  - Custom metric-based alerts
- **Drift Detection**: Automatic infrastructure drift detection
- **Health Checks**: Automated network health validation scripts
- **CI/CD Integration**: GitHub Actions workflows for continuous deployment

## Prerequisites

- Terraform >= 1.5.0
- Azure CLI >= 2.0
- Azure subscription
- GitHub account (for CI/CD)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/n-solano/terraform-azure-network-lifecycle-automation.git
cd terraform-azure-network-lifecycle-automation
