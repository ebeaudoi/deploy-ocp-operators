# Certified Elastic Cloud on Kubernetes (ECK) Operator

Deploy and manage the Certified Elastic Cloud on Kubernetes operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with ECK operator images
- **Catalog Source**: Certified catalog source configured in the cluster
- **Storage**: Storage class available for Elasticsearch data
- **Node Taints** (Optional): Dedicated nodes with taints for Elasticsearch

## Update Script

**Note**: This operator does not currently have an automated update script. Configuration must be updated manually in the kustomization files.

### Manual Update Steps

1. **Update operator overlay**:

```bash
cd certified-eck
vim operator/overlays/airgapped/kustomization.yaml
```

Update the following values:
- Subscription channel
- Certified catalog source name

## Deployment Steps

### 1. Prepare Nodes (Optional)

If using dedicated nodes for Elasticsearch, create nodes with specific taints:

```bash
# Example: Create nodes with Elasticsearch taints
# Refer to your infrastructure automation for node creation
```

### 2. Deploy ECK Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 3. Monitor Operator Installation

```bash
oc get pods -w -n elastic-system
```

Wait for all operator pods to be in `Running` state.

### 4. Deploy Elasticsearch Instance

```bash
oc create -f elasticsearch-instance.yaml
```

### 5. Deploy Kibana Instance

```bash
oc create -f kibana-instance.yaml
```

### 6. Create Kibana Route

```bash
oc create -f kibana-route.yaml
```

### 7. Get Elasticsearch User Password

```bash
oc get secret elasticsearch-instance-elastic-user -o go-template='{{.data.elastic | base64decode}}'
```

### 8. Verify Deployment

```bash
# Check Elasticsearch and Kibana status
oc get es,kb,pods -n elastic

# Check Elasticsearch route
oc get route -n elastic

# Check Elasticsearch service
oc get svc -n elastic | grep elasticsearch
```

## Directory Structure

```
certified-eck/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── elasticsearch-instance.yaml  # Elasticsearch instance CR
├── kibana-instance.yaml         # Kibana instance CR
├── kibana-route.yaml            # Kibana route configuration
├── es-route.yaml                # Elasticsearch route configuration
└── old/                         # Legacy configurations
```

## Troubleshooting

- **Operator not installing**: Verify certified catalog source is accessible and channel exists
- **Elasticsearch not ready**: Check storage class and PVC creation
- **Kibana not accessible**: Verify route configuration and service status
- **Node taints**: Ensure Elasticsearch pods can tolerate node taints if using dedicated nodes

## Note

This operator uses the Certified Operators catalog. Ensure your cluster has access to the certified catalog source configured for air-gapped environments.
