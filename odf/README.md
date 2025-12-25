# OpenShift Data Foundation (ODF) Operator

Deploy and manage the OpenShift Data Foundation operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with ODF operator images
- **Storage**: Available storage for ODF deployment
- **Catalog Source**: Red Hat catalog source configured in the cluster

## Update Script

The **`update-odf-values.sh`** script automates the update of ODF operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd odf
vim update-odf-values.sh
```

2. **Update the variables**:

```bash
ODF_SUBSCRIPTION_CHANNEL="stable-4.17"
ODF_CATALOG_SOURCE="your-redhat-catalog"
ODF_OSE_CLI_IMAGE="registry.example.com/openshift4/ose-cli@sha256:..."
ODF_STORAGE_CAPACITY="300Gi"
ODF_DEFAULT_STORAGE_CLASS="thin-csi"
```

3. **Run the script**:

```bash
./update-odf-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Update OSE CLI image for console plugin
- Update Noobaa storage capacity and default storage class
- Display a summary of all changes

## Deployment Steps

### 1. Deploy ODF Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-storage
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy Noobaa Instance

```bash
oc apply -k noobaa/overlays/airgapped/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-storage

# Check Noobaa services
oc get svc -n openshift-storage | grep noobaa

# Check storage system
oc get storagesystem -n openshift-storage
```

### 5. Important: Fix External IP (if needed)

If the Noobaa management service shows `<pending>` for EXTERNAL-IP:

```bash
# Check service status
oc get svc -n openshift-storage | grep noobaa-mgmt

# Edit Noobaa CR to disable LoadBalancer
oc edit noobaa noobaa -n openshift-storage
```

Add the following to the spec:
```yaml
spec:
  dbType: postgres
  disableLoadBalancerService: true
```

## Directory Structure

```
odf/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operatorgroup.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── noobaa/
│   ├── base/                    # Base Noobaa configuration
│   └── overlays/
│       └── airgapped/           # Air-gapped Noobaa overlay
│           ├── kustomization.yaml
│           └── patch-storage-capacity.yaml
└── update-odf-values.sh         # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Noobaa external IP pending**: Disable LoadBalancer service as shown above
- **Storage not available**: Check storage class configuration and node labels

