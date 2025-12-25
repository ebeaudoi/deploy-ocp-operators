# Jaeger Operator

Deploy and manage the Jaeger operator for distributed tracing in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Jaeger operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Dependencies**: Elasticsearch operator (for storage backend)

## Update Script

The **`update-jaeger-values.sh`** script automates the update of Jaeger operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd jaeger
vim update-jaeger-values.sh
```

2. **Update the variables**:

```bash
JAEGER_SUBSCRIPTION_CHANNEL="stable"
JAEGER_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-jaeger-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Jaeger Operator

```bash
oc apply -k overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-distributed-tracing
```

Wait for the Jaeger operator to be ready.

### 3. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-distributed-tracing

# Check Jaeger instance (if deployed)
oc get jaeger -n openshift-distributed-tracing

# Check Jaeger pods
oc get pods -n openshift-distributed-tracing
```

## Directory Structure

```
jaeger/
├── base/                        # Base operator configuration
│   ├── namespace.yaml
│   ├── operator-group.yaml
│   ├── subscription.yaml
│   └── kustomization.yaml
├── overlays/
│   └── airgapped/               # Air-gapped environment overlay
│       └── kustomization.yaml
└── update-jaeger-values.sh     # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Jaeger not collecting traces**: Check Service Mesh integration and Elasticsearch backend
- **Storage issues**: Verify Elasticsearch operator is installed and accessible

## Note

Jaeger is typically deployed automatically when Service Mesh Control Plane is installed. This operator can be used for standalone Jaeger deployments if needed.

