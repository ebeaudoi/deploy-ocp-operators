#!/bin/bash
####################################################
# Kiali Operator Update Script                    #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
KIALI_SUBSCRIPTION_CHANNEL="stable"
KIALI_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Kiali Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${KIALI_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${KIALI_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Kiali Operator] Updating operator overlay..."
echo "  File: overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${KIALI_SUBSCRIPTION_CHANNEL}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${KIALI_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${KIALI_CATALOG_SOURCE}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${KIALI_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "Kiali Operator update completed successfully"
echo "=========================================="
