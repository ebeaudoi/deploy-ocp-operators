# Kiali Operator

Deploy and manage the Kiali operator for Service Mesh observability in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Kiali operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Dependencies**: Service Mesh operator (Kiali is typically deployed as part of Service Mesh)

## Update Script

The **`update-kiali-values.sh`** script automates the update of Kiali operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd kiali
vim update-kiali-values.sh
```

2. **Update the variables**:

```bash
KIALI_SUBSCRIPTION_CHANNEL="stable"
KIALI_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-kiali-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Kiali Operator

```bash
oc apply -k overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-operators
```

Wait for the Kiali operator to be ready.

### 3. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-operators | grep kiali

# Check Kiali instance (if deployed separately)
oc get kiali -n istio-system

# Access Kiali console (if Service Mesh is deployed)
oc get route -n istio-system | grep kiali
```

## Directory Structure

```
kiali/
├── base/                        # Base operator configuration
│   ├── subscription.yaml
│   └── kustomization.yaml
├── overlays/
│   └── airgapped/               # Air-gapped environment overlay
│       └── kustomization.yaml
└── update-kiali-values.sh      # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Kiali not accessible**: Check Service Mesh Control Plane configuration
- **No data in Kiali**: Verify Service Mesh is properly configured and workloads are running

## Note

Kiali is typically deployed automatically when Service Mesh Control Plane is installed. This operator can be used for standalone Kiali deployments if needed.

