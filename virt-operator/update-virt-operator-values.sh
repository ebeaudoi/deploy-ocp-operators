#!/bin/bash
####################################################
# Virtualization Operator Update Script            #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
VIRT_OPERATOR_SUBSCRIPTION_CHANNEL="stable"
VIRT_OPERATOR_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Virtualization Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${VIRT_OPERATOR_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${VIRT_OPERATOR_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Virtualization Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${VIRT_OPERATOR_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${VIRT_OPERATOR_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${VIRT_OPERATOR_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${VIRT_OPERATOR_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "Virtualization Operator update completed successfully"
echo "=========================================="
