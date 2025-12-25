# Deploy OpenShift Operators

A comprehensive Kustomize-based repository for deploying OpenShift operators in air-gapped environments.

## Table of Contents

- [Project Overview](#project-overview)
- [Directory Structure](#directory-structure)
- [Project Architecture](#project-architecture)
- [Usage Guide](#usage-guide)
  - [Orchestrator Script](#orchestrator-script)
  - [Individual Operator Scripts](#individual-operator-scripts)
- [Variable Naming Convention](#variable-naming-convention)
- [Operator Deployment](#operator-deployment)
- [Available Operators](#available-operators)

---

## Project Overview

This repository provides a standardized approach to deploying and managing OpenShift operators in **air-gapped environments**. The project uses **Kustomize** to manage operator configurations with a consistent directory structure across all operators.

### Key Features

- **Standardized Structure**: All operators follow a consistent `base/` and `overlays/` directory pattern
- **Automated Updates**: Scripts to update operator configurations with standardized variable naming
- **Air-Gapped Support**: All configurations are designed for disconnected environments
- **Kustomize-Based**: Leverages Kustomize for declarative configuration management

---

## Directory Structure

```
deploy-ocp-operators/
├── update-all-operators-scripts.sh          # Orchestrator script to update all operators
│
├── odf/                                     # OpenShift Data Foundation
│   ├── operator/
│   │   ├── base/                            # Base operator configuration
│   │   └── overlays/                        # Environment-specific overlays
│   │       └── airgapped/
│   ├── noobaa/                              # Noobaa storage configuration
│   └── update-odf-values.sh                 # Update script
│
├── rhacm/                                    # Red Hat Advanced Cluster Management
│   ├── operator/
│   ├── instance/
│   ├── observability/
│   └── update-rhacm-values.sh
│
├── gitops/                                   # GitOps Operator
│   ├── operator/
│   ├── example-instance/
│   └── update-gitops-values.sh
│
├── virt-operator/                            # Virtualization Operator
│   ├── operator/
│   ├── instance/
│   └── update-virt-operator-values.sh
│
├── servicemesh/                              # Service Mesh Operator
│   ├── operator/
│   ├── instance/
│   └── update-servicemesh-values.sh
│
├── serverless/                                # Serverless Operator
│   ├── operator/
│   ├── instance/
│   └── update-serverless-values.sh
│
├── rhods/                                    # Red Hat OpenShift Data Science
│   ├── operator/
│   ├── instance/
│   └── update-rhods-values.sh
│
├── rhacs/                                    # Red Hat Advanced Cluster Security
│   ├── operator/
│   ├── central-secure-instance/
│   └── update-rhacs-values.sh
│
├── pipelines-operator/                        # Pipelines Operator
│   ├── base/
│   ├── overlays/
│   └── update-pipelines-operator-values.sh
│
├── logging/                                   # Logging Operator
│   ├── operator/
│   ├── loki/
│   ├── instance/
│   └── update-logging-values.sh
│
├── nutanix/                                   # Nutanix Operator
│   ├── operator/
│   ├── instance/
│   ├── storageclass/
│   └── update-nutanix-values.sh
│
├── kiali/                                    # Kiali Operator
│   ├── base/
│   ├── overlays/
│   └── update-kiali-values.sh
│
├── jaeger/                                   # Jaeger Operator
│   ├── base/
│   ├── overlays/
│   └── update-jaeger-values.sh
│
├── elasticsearch/                            # Elasticsearch Operator
│   ├── base/
│   ├── overlays/
│   └── update-elasticsearch-values.sh
│
├── nfd/                                      # Node Feature Discovery
│   ├── operator/
│   ├── instance/
│   └── update-nfd-values.sh
│
├── lvm-storage/                              # LVM Storage Operator
│   ├── operator/
│   └── update-lvm-storage-values.sh
│
├── local-storage/                            # Local Storage Operator
│   ├── operator/
│   └── update-local-storage-values.sh
│
├── openshift-api-for-data-protection-operator/  # OADP Operator
│   ├── operator/
│   └── update-oadp-values.sh
│
├── devspaces/                                # DevSpaces Operator
│   ├── operator/
│   └── instance/
│
├── rhsso/                                    # Red Hat Single Sign-On
│   ├── operator/
│   ├── instance/
│   └── rhsso-standalone/
│
├── quay/                                     # Quay Operator
│   └── operator/
│
├── certified-eck/                            # Certified Elastic Cloud on Kubernetes
│   └── operator/
│
└── enable-internal-registry/                 # Internal registry utilities
    ├── 01-patch-imageregistry.sh
    ├── 02-create-obc.sh
    └── 03-create-imageregistry-secret.sh
```

---

## Project Architecture

### Kustomize Hierarchy

The project follows a **standardized Kustomize structure**:

1. **Base Configuration** (`base/` or `operator/base/`)
   - Contains the base operator subscription, namespace, and operator group definitions
   - Environment-agnostic configuration

2. **Overlays** (`overlays/` or `operator/overlays/`)
   - Environment-specific customizations
   - Typically includes an `airgapped/` overlay for disconnected environments
   - Patches base configuration with environment-specific values (catalog sources, channels, etc.)

3. **Instance Configurations** (`instance/`)
   - Operator instance CRDs and configurations
   - Deployed after the operator is installed

### Standard Directory Pattern

Most operators follow this pattern:

```
{operator-name}/
├── operator/
│   ├── base/
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/
│           └── kustomization.yaml
├── instance/                    # Optional
│   └── base/
└── update-{operator}-values.sh  # Update script
```

---

## Usage Guide

### Orchestrator Script

The **`update-all-operators-scripts.sh`** script is the main orchestrator that updates all operator configuration scripts at once.

#### Features

- **Centralized Configuration**: Update all operator variables from a single location
- **Standardized Variables**: Uses consistent UPPER_SNAKE_CASE naming convention
- **Progress Tracking**: Color-coded output with success/failure indicators
- **Summary Report**: Provides a summary of all updates at the end

#### Usage

1. **Edit the orchestrator script** to set your values:

```bash
# Edit update-all-operators-scripts.sh
vim update-all-operators-scripts.sh
```

2. **Update the variable section** (lines 63-130):

```bash
## Shared/Common Variables ##
REDHAT_CATALOG_SOURCE="your-redhat-catalog"
CERTIFIED_CATALOG_SOURCE="your-certified-catalog"
OSE_CLI_IMAGE="your-ose-cli-image"

## Operator-Specific Variables ##
ODF_SUBSCRIPTION_CHANNEL="stable-4.17"
ODF_STORAGE_CAPACITY="300Gi"
# ... etc
```

3. **Run the orchestrator**:

```bash
./update-all-operators-scripts.sh
```

#### Output

The script provides:
- **Color-coded progress** for each operator
- **Success (✓)** and **failure (✗)** indicators
- **Summary statistics** at the end
- **Timestamp** information

Example output:
```
========================================
Operator Update Script Orchestrator
========================================
Started at: 2024-01-15 10:30:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ODF Operator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✓ File: odf/update-odf-values.sh
  ✓ ODF_CATALOG_SOURCE=your-catalog
  ✓ ODF_SUBSCRIPTION_CHANNEL=stable-4.17
  ...

========================================
Update Summary
========================================
  Total Operators Processed: 18
  Successful Updates:      18
  Failed Updates:         0

✓ All operators updated successfully!
```

---

### Individual Operator Scripts

Each operator folder contains an **`update-{operator}-values.sh`** script for updating that specific operator's configuration.

#### Standardized Script Structure

All update scripts follow this pattern:

1. **Variable Definitions** (UPPER_SNAKE_CASE)
2. **Backup Creation** (with timestamp)
3. **Configuration Display**
4. **Kustomization Updates** (using sed)
5. **Status Reporting**

#### Usage Example: ODF Operator

```bash
cd odf

# Edit the script
vim update-odf-values.sh

# Update variables
ODF_SUBSCRIPTION_CHANNEL="stable-4.17"
ODF_CATALOG_SOURCE="your-redhat-catalog"
ODF_OSE_CLI_IMAGE="your-ose-cli-image"
ODF_STORAGE_CAPACITY="300Gi"
ODF_DEFAULT_STORAGE_CLASS="thin-csi"

# Run the script
./update-odf-values.sh
```

#### Script Output

Each script provides:
- **Configuration summary** at the start
- **Progress indicators** for each update
- **Success/failure status** for each operation
- **Completion message**

Example:
```
==========================================
ODF Operator Configuration
==========================================
  Subscription Channel: stable-4.17
  Catalog Source:       your-redhat-catalog
  OSE CLI Image:        registry.example.com/...
  Storage Capacity:     300Gi
  Default Storage:      thin-csi
==========================================

[ODF Operator] Updating operator overlay...
  File: operator/overlays/airgapped/kustomization.yaml
    ✓ Updated subscription channel: stable-4.17
    ✓ Updated catalog source: your-redhat-catalog
    ✓ Updated OSE CLI image

==========================================
ODF Operator update completed successfully
==========================================
```

---

## Variable Naming Convention

All scripts use **UPPER_SNAKE_CASE** for consistency:

### Standard Variable Patterns

| Variable Type | Pattern | Example |
|--------------|---------|---------|
| Subscription Channel | `{OPERATOR}_SUBSCRIPTION_CHANNEL` | `ODF_SUBSCRIPTION_CHANNEL` |
| Catalog Source | `{OPERATOR}_CATALOG_SOURCE` | `ODF_CATALOG_SOURCE` |
| Certified Catalog | `{OPERATOR}_CERTIFIED_CATALOG_SOURCE` | `NUTANIX_CERTIFIED_CATALOG_SOURCE` |
| OSE CLI Image | `{OPERATOR}_OSE_CLI_IMAGE` | `RHACM_OSE_CLI_IMAGE` |
| Storage Class | `{OPERATOR}_STORAGE_CLASS` | `LOGGING_STORAGE_CLASS` |
| Storage Capacity | `{OPERATOR}_STORAGE_CAPACITY` | `ODF_STORAGE_CAPACITY` |
| Starting CSV | `{OPERATOR}_STARTING_CSV` | `SERVICEMESH_STARTING_CSV` |

### Shared Variables

The orchestrator script defines shared variables:

- **`REDHAT_CATALOG_SOURCE`**: Common Red Hat catalog source name
- **`CERTIFIED_CATALOG_SOURCE`**: Common certified catalog source name
- **`OSE_CLI_IMAGE`**: Common OSE CLI image reference

---

## Operator Deployment

### General Deployment Workflow

1. **Update Configuration**
   ```bash
   # Option 1: Use orchestrator (recommended)
   ./update-all-operators-scripts.sh
   
   # Option 2: Update individual operator
   cd {operator-name}
   ./update-{operator}-values.sh
   ```

2. **Deploy Operator**
   ```bash
   oc apply -k {operator-name}/operator/overlays/airgapped/
   ```

3. **Verify Installation**
   ```bash
   oc get pods -n {operator-namespace} -w
   ```

4. **Deploy Instance** (if applicable)
   ```bash
   oc apply -k {operator-name}/instance/base/
   ```

### Example: Deploying ODF Operator

```bash
# 1. Update configuration
cd odf
./update-odf-values.sh

# 2. Deploy operator
oc apply -k operator/overlays/airgapped/

# 3. Monitor installation
oc get pods -w -n openshift-storage

# 4. Deploy Noobaa instance
oc apply -k noobaa/overlays/airgapped/
```

---

## Available Operators

| Operator | Folder | Update Script | Namespace |
|----------|--------|---------------|-----------|
| **OpenShift Data Foundation** | `odf/` | `update-odf-values.sh` | `openshift-storage` |
| **RHACM** | `rhacm/` | `update-rhacm-values.sh` | `open-cluster-management` |
| **GitOps** | `gitops/` | `update-gitops-values.sh` | `openshift-gitops-operator` |
| **Virtualization** | `virt-operator/` | `update-virt-operator-values.sh` | `openshift-cnv` |
| **Service Mesh** | `servicemesh/` | `update-servicemesh-values.sh` | `openshift-operators` |
| **Serverless** | `serverless/` | `update-serverless-values.sh` | `openshift-serverless` |
| **RHODS** | `rhods/` | `update-rhods-values.sh` | `redhat-ods-operator` |
| **RHACS** | `rhacs/` | `update-rhacs-values.sh` | `rhacs-operator` |
| **Pipelines** | `pipelines-operator/` | `update-pipelines-operator-values.sh` | `openshift-operators` |
| **Logging** | `logging/` | `update-logging-values.sh` | `openshift-logging` |
| **Nutanix** | `nutanix/` | `update-nutanix-values.sh` | `openshift-cluster-csi-drivers` |
| **Kiali** | `kiali/` | `update-kiali-values.sh` | `openshift-operators` |
| **Jaeger** | `jaeger/` | `update-jaeger-values.sh` | `openshift-distributed-tracing` |
| **Elasticsearch** | `elasticsearch/` | `update-elasticsearch-values.sh` | `openshift-operators-redhat` |
| **NFD** | `nfd/` | `update-nfd-values.sh` | `openshift-nfd` |
| **LVM Storage** | `lvm-storage/` | `update-lvm-storage-values.sh` | `openshift-lvm-operator` |
| **Local Storage** | `local-storage/` | `update-local-storage-values.sh` | `openshift-local-storage` |
| **OADP** | `openshift-api-for-data-protection-operator/` | `update-oadp-values.sh` | `openshift-adp` |

---

## Best Practices

1. **Always Backup**: Scripts automatically create timestamped backups before modifications
2. **Test First**: Test updates in a non-production environment
3. **Use Orchestrator**: For bulk updates, use `update-all-operators-scripts.sh`
4. **Verify Changes**: Review the script output to ensure all updates succeeded
5. **Monitor Deployments**: Use `oc get pods -w` to monitor operator installations

---

## Troubleshooting

### Script Execution Issues

- **Permission Denied**: Ensure scripts are executable (`chmod +x *.sh`)
- **Variable Not Found**: Verify variable names match the standardized convention
- **sed Errors**: Check that file paths in scripts match your directory structure

### Deployment Issues

- **Operator Not Installing**: Check catalog source connectivity and channel availability
- **Image Pull Errors**: Verify image registry access in air-gapped environment
- **Resource Conflicts**: Ensure namespaces don't have conflicting resources

---

## Contributing

When adding new operators:

1. Follow the **standardized directory structure**
2. Use **UPPER_SNAKE_CASE** for all variables
3. Include an **`update-{operator}-values.sh`** script
4. Add the operator to the **orchestrator script**
5. Update this **README.md** with operator details

---

## License

This repository contains configuration files for deploying Red Hat OpenShift operators. Ensure you have appropriate Red Hat subscriptions and licenses for the operators you deploy.
