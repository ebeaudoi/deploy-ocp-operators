#!/bin/bash
####################################################
# Nutanix Operator Update Script                  #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
NUTANIX_SUBSCRIPTION_CHANNEL="stable"
NUTANIX_CERTIFIED_CATALOG_SOURCE="my-redhat-v413-catalog"
NUTANIX_PRISM_ISCSI_IP="10.10.10.10"
NUTANIX_PRISM_STORAGE_NAME="os-storage"
NUTANIX_PRISM_ELEMENT_LOGIN="10.10.17.90:9440:username:password"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp storageclass/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}

################################
# Display configuration         #
################################
echo "=========================================="
echo "Nutanix Operator Configuration"
echo "=========================================="
echo "  Subscription Channel:     ${NUTANIX_SUBSCRIPTION_CHANNEL}"
echo "  Certified Catalog Source: ${NUTANIX_CERTIFIED_CATALOG_SOURCE}"
echo "  PRISM ISCSI IP:            ${NUTANIX_PRISM_ISCSI_IP}"
echo "  PRISM Storage Name:        ${NUTANIX_PRISM_STORAGE_NAME}"
echo "  PRISM Element Login:       ${NUTANIX_PRISM_ELEMENT_LOGIN}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[Nutanix Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${NUTANIX_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${NUTANIX_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${NUTANIX_CERTIFIED_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${NUTANIX_CERTIFIED_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

echo ""

################################
# Update Storage Class Overlay  #
################################
echo "[Nutanix Storage Class] Updating storage class overlay..."
echo "  File: storageclass/overlays/airgapped/kustomization.yaml"

# Update PRISM Element ISCSI IP
sed -i "/path:\ \/parameters\/dataServiceEndPoint/{ n; s/value: .*$/value: ${NUTANIX_PRISM_ISCSI_IP}/g }" storageclass/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated PRISM Element ISCSI IP: ${NUTANIX_PRISM_ISCSI_IP}" || \
    echo "    ✗ Failed to update PRISM Element ISCSI IP"

# Update PRISM Element storage name
sed -i "/path:\ \/parameters\/storageContainer/{ n; s/value: .*$/value: ${NUTANIX_PRISM_STORAGE_NAME}/g }" storageclass/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated PRISM Element storage name: ${NUTANIX_PRISM_STORAGE_NAME}" || \
    echo "    ✗ Failed to update PRISM Element storage name"

# Update PRISM Element login information
sed -i "/path:\ \/stringData\/key/{ n; s/value: .*$/value: ${NUTANIX_PRISM_ELEMENT_LOGIN}/g }" storageclass/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated PRISM Element login information" || \
    echo "    ✗ Failed to update PRISM Element login information"

echo ""
echo "=========================================="
echo "Nutanix Operator update completed successfully"
echo "=========================================="
