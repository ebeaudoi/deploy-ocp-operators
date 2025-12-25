# Red Hat Advanced Cluster Management (RHACM) Operator

Deploy and manage the Red Hat Advanced Cluster Management operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with RHACM operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Infrastructure Nodes**: RHACM should be deployed on infrastructure nodes

## Update Script

The **`update-rhacm-values.sh`** script automates the update of RHACM operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd rhacm
vim update-rhacm-values.sh
```

2. **Update the variables**:

```bash
RHACM_SUBSCRIPTION_CHANNEL="release-2.12"
RHACM_CATALOG_SOURCE="your-redhat-catalog"
RHACM_OSE_CLI_IMAGE="registry.example.com/openshift4/ose-cli@sha256:..."
```

3. **Run the script**:

```bash
./update-rhacm-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Update observability OSE CLI image
- Update MultiClusterHub instance with catalog source annotation
- Display a summary of all changes

## Deployment Steps

### 1. Deploy RHACM Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n open-cluster-management
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy MultiClusterHub Instance

```bash
oc apply -k instance/overlays/airgapped/
```

### 4. Deploy Observability (Optional)

```bash
oc apply -k observability/overlays/airgapped/
```

### 5. Verify Deployment

```bash
# Check operator status
oc get csv -n open-cluster-management

# Check MultiClusterHub
oc get multiclusterhub -n open-cluster-management

# Check observability (if deployed)
oc get pods -w -n open-cluster-management-observability
```

## Directory Structure

```
rhacm/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operatorgroup.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── instance/
│   ├── base/                    # Base MultiClusterHub instance
│   │   └── multiclusterhub.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped instance overlay
│           └── kustomization.yaml
├── observability/
│   ├── base/                    # Base observability configuration
│   └── overlays/
│       └── airgapped/           # Air-gapped observability overlay
│           └── kustomization.yaml
└── update-rhacm-values.sh       # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Observability not working**: Check OSE CLI image is accessible from private registry
- **MultiClusterHub not ready**: Verify MCE subscription spec annotation is correctly set

