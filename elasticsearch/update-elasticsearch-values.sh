#!/bin/bash
####################################################
# Elasticsearch Operator Update Script              #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
ELASTICSEARCH_SUBSCRIPTION_CHANNEL="stable-5.8"
ELASTICSEARCH_CATALOG_SOURCE="ebdn-redhat-operators"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Elasticsearch Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${ELASTICSEARCH_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${ELASTICSEARCH_CATALOG_SOURCE}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Elasticsearch Operator] Updating operator overlay..."
echo "  File: overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${ELASTICSEARCH_SUBSCRIPTION_CHANNEL}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${ELASTICSEARCH_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${ELASTICSEARCH_CATALOG_SOURCE}/g }" overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${ELASTICSEARCH_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""
echo "=========================================="
echo "Elasticsearch Operator update completed successfully"
echo "=========================================="
