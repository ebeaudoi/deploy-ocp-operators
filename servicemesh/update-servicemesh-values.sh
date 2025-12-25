#!/bin/bash
####################################################
# Service Mesh Operator Update Script              #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
SERVICEMESH_SUBSCRIPTION_CHANNEL="stable"
SERVICEMESH_CATALOG_SOURCE="ebdn-redhat-operators"
SERVICEMESH_STARTING_CSV="servicemeshoperator.v2.4.5"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Service Mesh Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${SERVICEMESH_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${SERVICEMESH_CATALOG_SOURCE}"
echo "  Starting CSV:         ${SERVICEMESH_STARTING_CSV}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Service Mesh Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${SERVICEMESH_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${SERVICEMESH_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${SERVICEMESH_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${SERVICEMESH_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

# Update starting CSV
sed -i "/path:\ \/spec\/startingCSV/{ n; s/value: .*$/value: ${SERVICEMESH_STARTING_CSV}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated starting CSV: ${SERVICEMESH_STARTING_CSV}" || \
    echo "    ✗ Failed to update starting CSV"

echo ""
echo "=========================================="
echo "Service Mesh Operator update completed successfully"
echo "=========================================="
