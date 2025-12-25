# Serverless Operator

Deploy and manage the OpenShift Serverless (Knative) operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with Serverless operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Dependencies**: Service Mesh operator (for full integration)

## Update Script

The **`update-serverless-values.sh`** script automates the update of Serverless operator configuration files.

### Usage

1. **Edit the script** to set your values:

```bash
cd serverless
vim update-serverless-values.sh
```

2. **Update the variables**:

```bash
SERVERLESS_SUBSCRIPTION_CHANNEL="stable"
SERVERLESS_CATALOG_SOURCE="your-redhat-catalog"
```

3. **Run the script**:

```bash
./update-serverless-values.sh
```

The script will:
- Create timestamped backups of all kustomization files
- Update operator subscription channel and catalog source
- Display a summary of all changes

## Deployment Steps

### 1. Deploy Serverless Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n openshift-serverless
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy Knative Serving Instance (Optional)

```bash
oc apply -k instance/knative-serving/base/
```

Or with overlay:

```bash
oc apply -k instance/knative-serving/overlays/default/
```

### 4. Deploy Knative Eventing Instance (Optional)

```bash
oc apply -k instance/knative-eventing/base/
```

Or with overlay:

```bash
oc apply -k instance/knative-eventing/overlays/default/
```

### 5. Verify Deployment

```bash
# Check operator status
oc get csv -n openshift-serverless

# Check Knative Serving
oc get knativeserving -n knative-serving

# Check Knative Eventing
oc get knativeeventing -n knative-eventing

# Check pods
oc get pods -n knative-serving
oc get pods -n knative-eventing
```

## Directory Structure

```
serverless/
├── operator/
│   ├── base/                    # Base operator configuration
│   │   ├── namespace.yaml
│   │   ├── operator-group.yaml
│   │   ├── subscription.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       └── airgapped/           # Air-gapped environment overlay
│           └── kustomization.yaml
├── instance/
│   ├── knative-serving/         # Knative Serving instance
│   │   ├── base/
│   │   └── overlays/
│   │       └── default/
│   └── knative-eventing/         # Knative Eventing instance
│       ├── base/
│       └── overlays/
│           ├── default/
│           └── knative-kafka/
└── update-serverless-values.sh  # Configuration update script
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **Knative Serving not ready**: Check network policies and service mesh integration
- **Knative Eventing issues**: Verify Kafka operator is installed if using Kafka source

