# Node Feature Discovery (NFD) Operator

Deploy and manage the Node Feature Discovery operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with NFD operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster

## Update Script

The **`update-nfd-values.sh`** script automates the update of NFD operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd nfd
vim update-nfd-values.sh
```

2. **Update the variables**:

```bash
NFD_SUBSCRIPTION_CHANNEL="stable"
NFD_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-nfd-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy NFD Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-nfd
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy NFD Instance (Optional)

```bash
oc apply -k instance/base/
```

Or with overlay:

```bash
oc apply -k instance/overlays/default/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-nfd

# Check NodeFeatureDiscovery
oc get nodefeaturediscovery -n openshift-nfd

# Check node labels
oc get nodes --show-labels | grep feature

# Check NFD pods
oc get pods -n openshift-nfd
```

## Directory Structure

```
nfd/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── instance/
│   ├── base/                    # Base NodeFeatureDiscovery instance
│   │   ├── node-feature-discovery.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       ├── default/            # Default instance overlay
│       ├── kata/               # Kata containers overlay
│       └── only-nvidia/        # NVIDIA-only overlay
├── aggregate/                   # Feature aggregation
│   └── overlays/
└── update-nfd-values.sh       # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **No node labels**: Check NodeFeatureDiscovery CR is properly configured
- **NFD pods not running**: Verify node access and permissions

