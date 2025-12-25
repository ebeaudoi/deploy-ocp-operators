# Virtualization Operator

Deploy and manage the OpenShift Virtualization (CNV/KubeVirt) operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Virtualization operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Hardware**: Nodes with virtualization support (Intel VT-x or AMD-V)

## Update Script

The **`update-virt-operator-values.sh`** script automates the update of Virtualization operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd virt-operator
vim update-virt-operator-values.sh
```

2. **Update the variables**:

```bash
VIRT_OPERATOR_SUBSCRIPTION_CHANNEL="stable"
VIRT_OPERATOR_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-virt-operator-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Virtualization Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-cnv
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy HyperConverged Instance

```bash
oc apply -k instance/base/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-cnv

# Check HyperConverged CR
oc get hyperconverged -n openshift-cnv

# Check virtualization pods
oc get pods -n openshift-cnv
```

## Directory Structure

```
virt-operator/
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
│   └── base/                    # Base HyperConverged instance
│       ├── hyperconverged.yaml
│       └── kustomization.yaml
└── update-virt-operator-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Virtual machines not starting**: Check node hardware virtualization support
- **HyperConverged not ready**: Verify all required components are installed

