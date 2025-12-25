#!/bin/bash
####################################################
# RHACS Operator Update Script                     #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
RHACS_SUBSCRIPTION_CHANNEL="stable"
RHACS_CATALOG_SOURCE="ebdn-redhat-operators"
RHACS_OSE_CLI_IMAGE="registry.redhat.io/openshift4/ose-cli@sha256:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp central-secure-instance/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Prepare variables             #
################################
# Escape forward slashes for sed
RHACS_OSE_CLI_ESCAPED=$(echo "${RHACS_OSE_CLI_IMAGE}" | sed 's/\//\\\//g')

################################
# Display configuration         #
################################
echo "=========================================="
echo "RHACS Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${RHACS_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${RHACS_CATALOG_SOURCE}"
echo "  OSE CLI Image:        ${RHACS_OSE_CLI_IMAGE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[RHACS Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${RHACS_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${RHACS_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${RHACS_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${RHACS_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""

################################
# Update Central Secure Instance #
################################
echo "[RHACS Central Secure Instance] Updating central-secure-instance overlay..."
echo "  File: central-secure-instance/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${RHACS_SUBSCRIPTION_CHANNEL}/g }" central-secure-instance/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${RHACS_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${RHACS_CATALOG_SOURCE}/g }" central-secure-instance/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${RHACS_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

# Update OSE CLI image
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: ${RHACS_OSE_CLI_ESCAPED}/g }" central-secure-instance/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated OSE CLI image" || \
    echo "    ✗ Failed to update OSE CLI image"

echo ""
echo "=========================================="
echo "RHACS Operator update completed successfully"
echo "=========================================="
