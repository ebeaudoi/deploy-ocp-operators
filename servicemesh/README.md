# Service Mesh Operator

Deploy and manage the OpenShift Service Mesh (Istio) operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Service Mesh operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Dependencies**: Elasticsearch, Jaeger, and Kiali operators (for full observability)

## Update Script

The **`update-servicemesh-values.sh`** script automates the update of Service Mesh operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd servicemesh
vim update-servicemesh-values.sh
```

2. **Update the variables**:

```bash
SERVICEMESH_SUBSCRIPTION_CHANNEL="stable"
SERVICEMESH_CATALOG_SOURCE="your-redhat-catalog"
SERVICEMESH_STARTING_CSV="servicemeshoperator.v2.4.5"
```

3. **Run the script**:

```bash
./update-servicemesh-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Update starting CSV version
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Service Mesh Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-operators
```

Wait for the Service Mesh operator to be ready.

### 3. Deploy Service Mesh Control Plane (Optional)

```bash
oc apply -k instance/base/
```

Or with overlay:

```bash
oc apply -k instance/overlays/default/
```

### 4. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-operators | grep servicemesh

# Check ServiceMeshControlPlane
oc get smcp -n istio-system

# Check Service Mesh pods
oc get pods -n istio-system
```

## Directory Structure

```
servicemesh/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── instance/
│   ├── base/                    # Base ServiceMeshControlPlane
│   │   ├── namespace.yaml
│   │   ├── servicemesh-controlplane.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── default/             # Default instance overlay
│           └── kustomization.yaml
└── update-servicemesh-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Starting CSV not found**: Check that the specified CSV version exists in the catalog
- **Control plane not ready**: Verify all required operators (Elasticsearch, Jaeger, Kiali) are installed

