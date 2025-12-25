#!/bin/bash
####################################################
# ODF Operator Update Script                      #
# Updates kustomization.yaml files with new values #
####################################################

################################
# IMPORTANT                    #
# Update the variables below   #
################################
ODF_SUBSCRIPTION_CHANNEL="stable-4.17"
ODF_CATALOG_SOURCE="ebdn-redhat-operators"
ODF_OSE_CLI_IMAGE="registry.redhat.io/openshift4/ose-cli@sha256:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"
ODF_STORAGE_CAPACITY="300Gi"
ODF_DEFAULT_STORAGE_CLASS="thin-csi"

################################
# Backup the files             #
################################
BACKUP_SUFFIX=$(date +%Y%m%d-%HH%M)
cp operator/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp noobaa/overlays/airgapped/kustomization.yaml{,.${BACKUP_SUFFIX}}
cp noobaa/overlays/airgapped/patch-storage-capacity.yaml{,.${BACKUP_SUFFIX}}

################################
# Prepare variables             #
################################
# Escape forward slashes for sed
ODF_OSE_CLI_ESCAPED=$(echo "${ODF_OSE_CLI_IMAGE}" | sed 's/\//\\\//g')

################################
# Display configuration         #
################################
echo "=========================================="
echo "ODF Operator Configuration"
echo "=========================================="
echo "  Subscription Channel: ${ODF_SUBSCRIPTION_CHANNEL}"
echo "  Catalog Source:       ${ODF_CATALOG_SOURCE}"
echo "  OSE CLI Image:        ${ODF_OSE_CLI_IMAGE}"
echo "  Storage Capacity:     ${ODF_STORAGE_CAPACITY}"
echo "  Default Storage:      ${ODF_DEFAULT_STORAGE_CLASS}"
echo "=========================================="
echo ""

################################
# Update Operator Overlay       #
################################
echo "[ODF Operator] Updating operator overlay..."
echo "  File: operator/overlays/airgapped/kustomization.yaml"

# Update subscription channel
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: ${ODF_SUBSCRIPTION_CHANNEL}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated subscription channel: ${ODF_SUBSCRIPTION_CHANNEL}" || \
    echo "    ✗ Failed to update subscription channel"

# Update subscription catalog source
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: ${ODF_CATALOG_SOURCE}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated catalog source: ${ODF_CATALOG_SOURCE}" || \
    echo "    ✗ Failed to update catalog source"

# Update OSE CLI image
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: ${ODF_OSE_CLI_ESCAPED}/g }" operator/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated OSE CLI image" || \
    echo "    ✗ Failed to update OSE CLI image"

echo ""

################################
# Update Noobaa Configuration   #
################################
echo "[ODF Noobaa] Updating Noobaa configuration..."
echo "  File: noobaa/overlays/airgapped/kustomization.yaml"

# Update storage capacity
sed -i "/path:\ \/spec\/pvPool\/resources\/requests\/storage/{ n; s/value: .*$/value: ${ODF_STORAGE_CAPACITY}/g }" noobaa/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated storage capacity: ${ODF_STORAGE_CAPACITY}" || \
    echo "    ✗ Failed to update storage capacity"

# Update default storage class
sed -i "/path:\ \/spec\/multiCloudGateway\/dbStorageClassName/{ n; s/value: .*$/value: ${ODF_DEFAULT_STORAGE_CLASS}/g }" noobaa/overlays/airgapped/kustomization.yaml && \
    echo "    ✓ Updated default storage class: ${ODF_DEFAULT_STORAGE_CLASS}" || \
    echo "    ✗ Failed to update default storage class"

echo ""
echo "=========================================="
echo "ODF Operator update completed successfully"
echo "=========================================="
