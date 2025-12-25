#!/bin/bash
####################################################
# RHACM Operator Update Script                    #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
RHACM_SUBSCRIPTION_CHANNEL="release-2.12"
RHACM_CATALOG_SOURCE="ebdn-redhat-operators"
RHACM_OSE_CLI_IMAGE="registry.redhat.io/openshift4/ose-cli@sha256:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp observability/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp instance/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Prepare variables             #
################################
# Escape forward slashes for sed
RHACM_OSE_CLI_ESCAPED=$(echo "${RHACM_OSE_CLI_IMAGE}" | sed 's/\//\\\//g')
# Prepare MCE subscription spec annotation
MCE_SUBSCRIPTION_SPEC="\ \ \ \ \ \ \ \ \ installer\.open-cluster-management\.io\/mce-subscription-spec: \'\{\\\"source\\\": \\\"${RHACM_CATALOG_SOURCE}\\\"\}\'"

################################
# Display configuration         #
################################
echo "=========================================="
echo "RHACM Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${RHACM_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${RHACM_CATALOG_SOURCE}"
echo "  OSE CLI Image:        ${RHACM_OSE_CLI_IMAGE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[RHACM Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${RHACM_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${RHACM_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${RHACM_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${RHACM_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""

################################
# Update Observability Overlay  #
################################
echo "[RHACM Observability] Updating observability overlay..."
echo "  File: observability/overlays/airgapped/kustomization.yaml"

# Update OSE CLI image
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: ${RHACM_OSE_CLI_ESCAPED}/g }" observability/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated OSE CLI image" || \
    echo "    ✗ Failed to update OSE CLI image"

echo ""

################################
# Update Instance Overlay       #
################################
echo "[RHACM Instance] Updating MultiClusterHub instance overlay..."
echo "  File: instance/overlays/airgapped/kustomization.yaml"

# Update MCE subscription spec annotation
sed -i "/.*mce-subscription-spec.*/c ${MCE_SUBSCRIPTION_SPEC}" instance/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated MCE subscription spec with catalog: ${RHACM_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update MCE subscription spec"

echo ""
echo "=========================================="
echo "RHACM Operator update completed successfully"
echo "=========================================="
