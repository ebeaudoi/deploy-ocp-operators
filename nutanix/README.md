# Nutanix Operator

Deploy and manage the Nutanix CSI driver operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Nutanix operator images
- **Certified Catalog Source**: Certified catalog source configured in the cluster
- **Nutanix Prism**: Access to Nutanix Prism Element with credentials
- **Network Access**: Network connectivity to Nutanix Prism Element

## Update Script

The **`update-nutanix-values.sh`** script automates the update of Nutanix operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd nutanix
vim update-nutanix-values.sh
```

2. **Update the variables**:

```bash
NUTANIX_SUBSCRIPTION_CHANNEL="stable"
NUTANIX_CERTIFIED_CATALOG_SOURCE="your-certified-catalog"
NUTANIX_PRISM_ISCSI_IP="10.10.10.10"
NUTANIX_PRISM_STORAGE_NAME="os-storage"
NUTANIX_PRISM_ELEMENT_LOGIN="10.10.17.90:9440:username:password"
```

3. **Run the script**:

```bash
./update-nutanix-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and certified catalog source
- Update storage class with Prism Element ISCSI IP
- Update storage class with Prism Element storage name
- Update storage class with Prism Element login credentials
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Nutanix Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-cluster-csi-drivers
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy Nutanix Instance

```bash
oc apply -k instance/base/
```

### 4. Deploy Storage Class

```bash
oc apply -k storageclass/overlays/airgapped/
```

### 5. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-cluster-csi-drivers

# Check storage class
oc get storageclass | grep nutanix

# Check Nutanix CSI driver
oc get pods -n openshift-cluster-csi-drivers
```

## Directory Structure

```
nutanix/
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
│   └── base/                    # Base Nutanix instance
│       └── *.yaml
├── storageclass/
│   └── overlays/
│       └── airgapped/           # Air-gapped storage class overlay
│           └── kustomization.yaml
└── update-nutanix-values.sh    # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify certified catalog source is accessible and channel exists
- **Storage class not working**: Check Prism Element connectivity and credentials
- **CSI driver not ready**: Verify network access to Prism Element ISCSI endpoint

