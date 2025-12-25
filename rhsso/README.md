# Red Hat Single Sign-On (RHSSO) Operator

Deploy and manage the Red Hat Single Sign-On operator in air-gapped environments using Kustomize.

## Prerequisites

- **OpenShift CLI (`oc`)**: Version 4.x or later
- **Cluster Access**: Admin access to the OpenShift cluster
- **Air-Gapped Environment**: Access to internal registry with RHSSO operator images
- **Catalog Source**: Red Hat catalog source configured in the cluster
- **Database**: PostgreSQL database (can be deployed via operator or external)

## Update Script

**Note**: This operator does not currently have an automated update script. Configuration must be updated manually in the kustomization files.

### Manual Update Steps

1. **Update operator overlay**:

```bash
cd rhsso
vim operator/overlays/airgapped/kustomization.yaml
```

Update the following values:
- Subscription channel
- Catalog source name
- PostgreSQL image (from private registry)

2. **Update instance overlay** (if needed):

```bash
vim instance/overlays/airgapped/kustomization.yaml
```

## Deployment Steps

### 1. Deploy RHSSO Operator

```bash
oc apply -k operator/overlays/airgapped/
```

### 2. Monitor Operator Installation

```bash
oc get pods -w -n sso
```

Wait for all operator pods to be in `Running` state.

### 3. Deploy RHSSO Instance

```bash
oc apply -k instance/overlays/airgapped/
```

Or with CRC overlay:

```bash
oc apply -k instance/overlays/crc/
```

### 4. Deploy RHSSO Standalone (Alternative)

For standalone deployment without operator:

```bash
oc apply -k rhsso-standalone/base/
```

Or with overlay:

```bash
oc apply -k rhsso-standalone/overlays/default/
```

### 5. Verify Deployment

```bash
# Check operator status
oc get csv -n sso

# Check Keycloak instance
oc get keycloak -n sso

# Check RHSSO pods
oc get pods -n sso

# Check route
oc get route -n sso
```

## Directory Structure

```
rhsso/
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
│   ├── base/                    # Base Keycloak instance
│   │   ├── sso.yaml
│   │   └── kustomization.yaml
│   └── overlays/
│       ├── airgapped/           # Air-gapped instance overlay
│       └── crc/                 # CRC-specific overlay
├── rhsso-standalone/             # Standalone deployment (no operator)
│   ├── base/
│   └── overlays/
│       └── default/
└── instance/README.md            # Additional instance documentation
```

## Troubleshooting

- **Operator not installing**: Verify catalog source is accessible and channel exists
- **PostgreSQL not ready**: Check PostgreSQL image is accessible from private registry
- **Keycloak not accessible**: Check route configuration and service status

