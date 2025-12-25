# Local Storage Operator

Deploy and manage the OpenShift Local Storage operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Local Storage operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Storage**: Available local disks on worker nodes for local storage

## Update Script

The **`update-local-storage-values.sh`** script automates the update of Local Storage operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd local-storage
vim update-local-storage-values.sh
```

2. **Update the variables**:

```bash
LOCAL_STORAGE_SUBSCRIPTION_CHANNEL="stable"
LOCAL_STORAGE_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-local-storage-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Local Storage Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-local-storage
```

Wait for all operator pods to be in `Running` state.

### 3. Create Local Volume Set (Optional)

Refer to the examples in the `examples/` directory for LocalVolumeSet configurations.

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-local-storage

# Check LocalVolumeSet (if deployed)
oc get localvolumeset -n openshift-local-storage

# Check storage class
oc get storageclass | grep local

# Check pods
oc get pods -n openshift-local-storage
```

## Directory Structure

```
local-storage/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── examples/                    # Example LocalVolumeSet configurations
│   ├── local-volume-discovery.yaml
│   ├── local-volume-set.yaml
│   └── local-volume.yaml
└── update-local-storage-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **No storage class created**: Check LocalVolumeSet CR is properly configured
- **Storage not available**: Verify nodes have available local disks and are properly labeled
