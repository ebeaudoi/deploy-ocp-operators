# Elasticsearch Operator

Deploy and manage the OpenShift Elasticsearch operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Elasticsearch operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Storage**: Storage class available for Elasticsearch data

## Update Script

The **`update-elasticsearch-values.sh`** script automates the update of Elasticsearch operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd elasticsearch
vim update-elasticsearch-values.sh
```

2. **Update the variables**:

```bash
ELASTICSEARCH_SUBSCRIPTION_CHANNEL="stable-5.8"
ELASTICSEARCH_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-elasticsearch-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Elasticsearch Operator

```bash
oc apply -k overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-operators-redhat
```

Wait for the Elasticsearch operator to be ready.

### 3. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-operators-redhat | grep elasticsearch

# Check Elasticsearch instances (if deployed)
oc get elasticsearch -A

# Check pods
oc get pods -n openshift-operators-redhat | grep elasticsearch
```

## Directory Structure

```
elasticsearch/
├── base/                        # Base operator configuration
│   ├── namespace.yaml
│   ├── operator-group.yaml
│   ├── subscription.yaml
│   └── kustomization.yaml
├── overlays/
│   └── airgapped/               # Air-gapped environment overlay
│       └── kustomization.yaml
└── update-elasticsearch-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Elasticsearch not ready**: Check storage class and PVC creation
- **Storage issues**: Verify storage class is available and nodes have storage

## Note

Elasticsearch operator is typically used as a storage backend for Logging and Jaeger operators. It can also be used for standalone Elasticsearch deployments.
