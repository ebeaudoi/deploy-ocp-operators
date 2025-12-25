# Quay Operator

Deploy and manage the Red Hat Quay operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Quay operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Database**: PostgreSQL database for Quay metadata
- **Object Storage**: Object storage for Quay image storage

## Update Script

**Note**: This operator does not currently have an automated update script. Configuration must be updated manually in the kustomization files.

### Manual Update Steps

1. **Update operator overlay**:

```bash
cd quay
vim operator/overlay/airgapped/kustomization.yaml
```

Update the following values:
- Subscription channel
- Catalog source name

## Deployment Steps

### 1. Deploy Quay Operator

```bash
oc apply -k operator/overlay/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n quay-operator
```

Wait for all operator pods to be in `Running` state.

### 3. Create Quay Instance (Manual)

After the operator is installed, create a QuayRegistry CR to deploy a Quay instance. This typically requires:

- PostgreSQL database configuration
- Object storage configuration (S3-compatible)
- Redis configuration (optional, for image scanning)

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n quay-operator

# Check QuayRegistry (if deployed)
oc get quayregistry -n quay-operator

# Check Quay pods
oc get pods -n quay-operator
```

## Directory Structure

```
quay/
└── operator/
    ├── base/                    # Base operator configuration
    │   ├── namespace.yaml
    │   ├── operator-group.yaml
    │   ├── subscription.yaml
    │   └── kustomization.yaml
    └── overlay/
        └── airgapped/           # Air-gapped environment overlay
            └── kustomization.yaml
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Quay instance not ready**: Check database and object storage connectivity
- **Image push/pull failures**: Verify object storage credentials and network access

## Note

Quay instance deployment requires manual creation of a QuayRegistry CR with proper database and storage configuration. Refer to Red Hat Quay documentation for detailed instance configuration.

