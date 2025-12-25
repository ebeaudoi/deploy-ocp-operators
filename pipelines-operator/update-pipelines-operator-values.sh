#!/bin/bash
####################################################
# Pipelines Operator Update Script                 #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL="latest"
PIPELINES_OPERATOR_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Pipelines Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${PIPELINES_OPERATOR_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Pipelines Operator] Updating operator overlay..."
echo "  File: overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${PIPELINES_OPERATOR_CATALOG_SOURCE}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${PIPELINES_OPERATOR_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "Pipelines Operator update completed successfully"
echo "=========================================="
