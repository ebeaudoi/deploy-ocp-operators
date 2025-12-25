#!/bin/bash
####################################################
# Logging Operator Update Script                  #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
LOGGING_SUBSCRIPTION_CHANNEL="stable-5.8"
LOKI_SUBSCRIPTION_CHANNEL="stable-5.8"
LOGGING_CATALOG_SOURCE="ebdn-redhat-operators"
LOGGING_STORAGE_CLASS="storageclass"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp loki/operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp loki/instance/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Logging Operator Configuration"
echo "=========================================="
echo "  Logging Channel:      ${LOGGING_SUBSCRIPTION_CHANNEL}"
echo "  Loki Channel:         ${LOKI_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${LOGGING_CATALOG_SOURCE}"
echo "  Storage Class:        ${LOGGING_STORAGE_CLASS}"
echo "=========================================="
echo ""

################################
# Update Logging Operator       #
################################
echo "[Logging Operator] Updating logging operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update logging subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${LOGGING_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated logging subscription channel: ${LOGGING_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update logging subscription channel"

# Update logging subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${LOGGING_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated logging catalog source: ${LOGGING_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update logging catalog source"

echo ""

################################
# Update Loki Operator          #
################################
echo "[Loki Operator] Updating Loki operator overlay..."
echo "  File: loki/operator/overlays/airgapped/kustomization.yaml"

# Update Loki subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${LOKI_SUBSCRIPTION_CHANNEL}/g }" loki/operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated Loki subscription channel: ${LOKI_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update Loki subscription channel"

# Update Loki subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${LOGGING_CATALOG_SOURCE}/g }" loki/operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated Loki catalog source: ${LOGGING_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update Loki catalog source"

echo ""

################################
# Update Loki Instance          #
################################
echo "[Loki Instance] Updating Loki instance overlay..."
echo "  File: loki/instance/overlays/airgapped/kustomization.yaml"

# Update Loki instance storage class
sed -i "/path:\ \/spec\/storageClassName/{ n; s/value: .*$/value: ${LOGGING_STORAGE_CLASS}/g }" loki/instance/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated Loki storage class: ${LOGGING_STORAGE_CLASS}" || \
    echo "    ✗ Failed to update Loki storage class"

echo ""
echo "=========================================="
echo "Logging Operator update completed successfully"
echo "=========================================="
