#!/bin/bash
####################################################
# NFD Operator Update Script                       #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
NFD_SUBSCRIPTION_CHANNEL="stable"
NFD_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "NFD Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${NFD_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${NFD_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[NFD Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${NFD_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${NFD_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${NFD_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${NFD_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "NFD Operator update completed successfully"
echo "=========================================="
