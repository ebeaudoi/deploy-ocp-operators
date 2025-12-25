# Logging Operator

Deploy and manage the OpenShift Logging operator and Loki in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Logging operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Storage**: Storage class available for Loki storage
- **Object Storage**: Object storage bucket for Loki (if using ODF)

## Update Script

The **`update-logging-values.sh`** script automates the update of Logging operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd logging
vim update-logging-values.sh
```

2. **Update the variables**:

```bash
LOGGING_SUBSCRIPTION_CHANNEL="stable-5.8"
LOKI_SUBSCRIPTION_CHANNEL="stable-5.8"
LOGGING_CATALOG_SOURCE="your-redhat-catalog"
LOGGING_STORAGE_CLASS="storageclass"
```

3. **Run the script**:

```bash
./update-logging-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update logging operator subscription channel and catalog source
- Update Loki operator subscription channel and catalog source
- Update Loki instance storage class
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Logging Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Logging Operator Installation

```bash
oc get pods -w -n openshift-logging
```

Wait for the operator to be ready.

### 3. Deploy Loki Operator

```bash
oc apply -k loki/operator/overlays/airgapped/
```

### 4. Monitor Loki Operator Installation

```bash
oc get pods -w -n openshift-operators-redhat
```

### 5. Create Loki Object Storage (if using ODF)

```bash
# Create ObjectBucketClaim for Loki
oc create -f 01-create-logging-obc.yaml

# Create Loki OBC secret
./02-create-loki-obc-secret.sh
```

### 6. Deploy Loki Instance

```bash
oc apply -k loki/instance/overlays/airgapped/
```

### 7. Deploy Logging Instance

```bash
oc apply -k instance/overlays/airgapped/
```

### 8. Enable Logging Console Plugin

```bash
oc edit consoles.operator.openshift.io cluster
```

Add the following to the spec:
```yaml
spec:
  plugins:
  - logging-view-plugin
```

### 9. Verify Deployment

```bash
# Check logging operator
oc get pods,pvc -n openshift-logging

# Check Loki
oc get pods -n openshift-logging | grep loki

# Check cluster logging
oc get clusterlogging -n openshift-logging
```

## Directory Structure

```
logging/
├── operator/
│   ├── base/                    # Base logging operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── loki/
│   ├── operator/
│   │   ├── base/                # Base Loki operator configuration
│   │   └── overlays/
│   │       └── airgapped/
│   └── instance/
│       ├── base/                # Base Loki instance
│       └── overlays/
│           └── airgapped/
├── instance/
│   ├── base/                    # Base logging instance
│   └── overlays/
│       └── airgapped/
├── 01-create-logging-obc.yaml   # ObjectBucketClaim for Loki
├── 02-create-loki-obc-secret.sh # Script to create Loki secret
└── update-logging-values.sh     # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Loki storage issues**: Check storage class and PVC creation
- **Logs not appearing**: Verify cluster logging CR is properly configured
- **Console plugin not showing**: Ensure plugin is enabled in console operator

