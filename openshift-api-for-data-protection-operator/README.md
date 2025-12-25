# OpenShift API for Data Protection (OADP) Operator

Deploy and manage the OpenShift API for Data Protection operator (Velero) in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with OADP operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Object Storage**: Object storage backend for backups (S3-compatible)

## Update Script

The **`update-oadp-values.sh`** script automates the update of OADP operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd openshift-api-for-data-protection-operator
vim update-oadp-values.sh
```

2. **Update the variables**:

```bash
OADP_SUBSCRIPTION_CHANNEL="ebdnlatest"
OADP_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-oadp-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy OADP Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-adp
```

Wait for all operator pods to be in `Running` state.

### 3. Configure Backup Storage

Create a secret with your object storage credentials:

```bash
oc create secret generic cloud-credentials \
  --from-literal cloud=openshift/adp/aws/bucket \
  --from-literal aws_access_key_id=<your-access-key> \
  --from-literal aws_secret_access_key=<your-secret-key> \
  -n openshift-adp
```

### 4. Create DataProtectionApplication (Optional)

Create a DataProtectionApplication CR to configure Velero with your backup storage.

### 5. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-adp

# Check DataProtectionApplication (if deployed)
oc get dataprotectionapplication -n openshift-adp

# Check Velero pods
oc get pods -n openshift-adp
```

## Directory Structure

```
openshift-api-for-data-protection-operator/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
└── update-oadp-values.sh        # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Backups not working**: Check object storage credentials and connectivity
- **Velero not ready**: Verify DataProtectionApplication CR is properly configured

