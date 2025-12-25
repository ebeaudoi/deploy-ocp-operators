#!/bin/bash
####################################################
# Jaeger Operator Update Script                    #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
JAEGER_SUBSCRIPTION_CHANNEL="stable"
JAEGER_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Jaeger Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${JAEGER_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${JAEGER_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Jaeger Operator] Updating operator overlay..."
echo "  File: overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${JAEGER_SUBSCRIPTION_CHANNEL}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${JAEGER_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${JAEGER_CATALOG_SOURCE}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${JAEGER_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "Jaeger Operator update completed successfully"
echo "=========================================="
