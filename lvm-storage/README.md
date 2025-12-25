# LVM Storage Operator

Deploy and manage the OpenShift LVM Storage operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with LVM Storage operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Storage**: Available local disks on worker nodes for LVM storage

## Update Script

The **`update-lvm-storage-values.sh`** script automates the update of LVM Storage operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd lvm-storage
vim update-lvm-storage-values.sh
```

2. **Update the variables**:

```bash
LVM_STORAGE_SUBSCRIPTION_CHANNEL="stable"
LVM_STORAGE_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-lvm-storage-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy LVM Storage Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-lvm-operator
```

Wait for all operator pods to be in `Running` state.

### 3. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-lvm-operator

# Check LVMCluster (if deployed)
oc get lvmcluster -n openshift-storage

# Check storage class
oc get storageclass | grep lvm

# Check pods
oc get pods -n openshift-lvm-operator
```

## Directory Structure

```
lvm-storage/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
└── update-lvm-storage-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **No storage class created**: Check LVMCluster CR is properly configured
- **Storage not available**: Verify nodes have available local disks
