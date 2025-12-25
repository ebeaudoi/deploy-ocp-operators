# DevSpaces Operator

Deploy and manage the Red Hat DevSpaces operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with DevSpaces operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Storage**: Storage class available for DevSpaces workspaces

## Update Script

**Note**: This operator does not currently have an automated update script. Configuration must be updated manually in the kustomization files.

### Manual Update Steps

1. **Update operator overlay**:

```bash
cd devspaces
vim operator/overlays/airgapped/kustomization.yaml
```

Update the following values:
- Subscription channel
- Catalog source name

2. **Update instance overlay** (if needed):

```bash
vim instance/overlays/airgapped/kustomization.yaml
```

## Deployment Steps

### 1. Deploy DevSpaces Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-devspaces
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy DevSpaces Instance

```bash
oc apply -k instance/overlays/airgapped/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-devspaces

# Check CheCluster
oc get checluster -n openshift-devspaces

# Check DevSpaces pods
oc get pods -n openshift-devspaces
```

## Directory Structure

```
devspaces/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
└── instance/
    ├── base/                    # Base CheCluster instance
    │   ├── namespace.yaml
    │   ├── checluster.yaml
    │   └── kustomization.yaml
    └── overlays/
        └── airgapped/           # Air-gapped instance overlay
            └── kustomization.yaml
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **DevSpaces not accessible**: Check route configuration and network policies
- **Workspace creation fails**: Verify storage class is available and properly configured

