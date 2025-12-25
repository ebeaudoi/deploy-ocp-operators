# Red Hat Advanced Cluster Security (RHACS) Operator

Deploy and manage the Red Hat Advanced Cluster Security for Kubernetes operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with RHACS operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Infrastructure Nodes**: RHACS should be deployed on infrastructure nodes

## Update Script

The **`update-rhacs-values.sh`** script automates the update of RHACS operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd rhacs
vim update-rhacs-values.sh
```

2. **Update the variables**:

```bash
RHACS_SUBSCRIPTION_CHANNEL="stable"
RHACS_CATALOG_SOURCE="your-redhat-catalog"
RHACS_OSE_CLI_IMAGE="registry.example.com/openshift4/ose-cli@sha256:..."
```

3. **Run the script**:

```bash
./update-rhacs-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Update central-secure-instance subscription channel and catalog source
- Update central-secure-instance OSE CLI image
- Display a summary of all changes

## Deployment Steps

### 1. Deploy RHACS Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n rhacs-operator
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy Central and Secured Cluster Instance

```bash
oc apply -k central-secure-instance/overlays/airgapped/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n rhacs-operator

# Check Central
oc get central -n stackrox

# Check SecuredCluster
oc get securedcluster -n stackrox

# Check pods
oc get pods -n stackrox
```

## Directory Structure

```
rhacs/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── central-secure-instance/
│   ├── base/                    # Base Central and SecuredCluster
│   │   ├── namespace.yaml
│   │   ├── central.yaml
│   │   ├── secured-cluster.yaml
│   │   ├── create-cluster-init-bundle-job.yaml
│   │   ├── create-cluster-init-bundle-sa.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped instance overlay
│           └── kustomization.yaml
└── update-rhacs-values.sh      # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Central not ready**: Check OSE CLI image is accessible from private registry
- **SecuredCluster not connecting**: Verify cluster init bundle is created and applied

