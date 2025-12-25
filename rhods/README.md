# Red Hat OpenShift Data Science (RHODS) Operator

Deploy and manage the Red Hat OpenShift Data Science operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with RHODS operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Dependencies**: 
  - Pipeline operator
  - Serverless operator
  - Service Mesh operator
  - Elasticsearch operator
  - Jaeger operator
  - Kiali operator

## Update Script

The **`update-rhods-values.sh`** script automates the update of RHODS operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd rhods
vim update-rhods-values.sh
```

2. **Update the variables**:

```bash
RHODS_SUBSCRIPTION_CHANNEL="stable"
RHODS_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-rhods-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy RHODS Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n redhat-ods-operator
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy Data Science Cluster Instance

```bash
oc apply -k instance/base/
```

Or with overlay:

```bash
oc apply -k instance/overlays/airgapped/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n redhat-ods-operator

# Check DataScienceCluster
oc get datasciencecluster -n redhat-ods-applications

# Check pods in RHODS namespaces
oc get pods -n redhat-ods-applications
oc get pods -n redhat-ods-monitoring
oc get pods -n redhat-ods-operator
```

## Directory Structure

```
rhods/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── namespace-ods-applications.yaml
│   │   ├── namespace-ods-monitoring.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── instance/
│   ├── base/                    # Base DataScienceCluster instance
│   │   ├── datasciencecluster.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped instance overlay
│           └── kustomization.yaml
└── update-rhods-values.sh      # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Prerequisites not met**: Ensure all required operators are installed first
- **DataScienceCluster not ready**: Check all component status in the CR

## Note

The following projects will be created automatically:
- `redhat-ods-applications`
- `redhat-ods-monitoring`
- `redhat-ods-operator`

