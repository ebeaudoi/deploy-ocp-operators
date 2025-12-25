#!/bin/bash
####################################################
# LVM Storage Operator Update Script                #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
LVM_STORAGE_SUBSCRIPTION_CHANNEL="stable"
LVM_STORAGE_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "LVM Storage Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${LVM_STORAGE_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${LVM_STORAGE_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[LVM Storage Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${LVM_STORAGE_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${LVM_STORAGE_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${LVM_STORAGE_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${LVM_STORAGE_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "LVM Storage Operator update completed successfully"
echo "=========================================="
