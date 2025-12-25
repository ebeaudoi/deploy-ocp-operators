# Pipelines Operator

Deploy and manage the OpenShift Pipelines (Tekton) operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Pipelines operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster

## Update Script

The **`update-pipelines-operator-values.sh`** script automates the update of Pipelines operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd pipelines-operator
vim update-pipelines-operator-values.sh
```

2. **Update the variables**:

```bash
PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL="latest"
PIPELINES_OPERATOR_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-pipelines-operator-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Pipelines Operator

```bash
oc apply -k overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-operators
```

Wait for the Pipelines operator to be ready.

### 3. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-operators | grep pipelines

# Check Tekton resources
oc get pods -n openshift-pipelines

# Check TektonConfig
oc get tektonconfig -n openshift-pipelines
```

## Directory Structure

```
pipelines-operator/
├── base/                        # Base operator configuration
│   ├── subscription.yaml
│   └── kustomization.yaml
├── overlays/
│   └── airgapped/               # Air-gapped environment overlay
│       └── kustomization.yaml
└── update-pipelines-operator-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Pipelines not working**: Check TektonConfig CR is properly configured
- **Build failures**: Verify image registry access and credentials

