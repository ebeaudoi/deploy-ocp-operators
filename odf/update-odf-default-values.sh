#!/bin/bash
################################
# IMPORTANT                    #
# Update the 3 below variables #
CHANNEL="stable-4.17"
RHCATALOG="ebdn-redhat-operators"
OSE_CLI_IMAGE="registry.redhat.io/openshift4/ose-cli@sha256:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"
CAPACITY="300Gi"
DEFAULT_STORAGE="thin-csi"
# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp noobaa/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp noobaa/overlay/airgapped/patch-storage-capacity.yaml{,.$(date +%Y%m%d-%HH%M)}
OSE_CLI=$( echo $OSE_CLI_IMAGE |sed 's/\//\\\//g')
# Showing new values
echo "-----------------------------"
echo "Channel = $CHANNEL"
echo "Catalog = $RHCATALOG"
echo "OSE CLI = $OSE_CLI"
echo "CAPACITY = $CAPACITY"
echo "D. Storage = $DEFAULT_STORAGE"
echo "-----------------------------"

###################################o#
# Update operator overlay yaml file #
  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RHCATALOG/g }" operator/overlay/airgapped/kustomization.yaml
  # Update image to enable console
echo "-- Update ose cli image --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: $OSE_CLI/g }" operator/overlay/airgapped/kustomization.yaml

####################################
# Update Noobaa                    #
  #Capacity
echo "-- Update storage capacity --"
echo "File: noobaa/overlay/airgapped/patch-storage-capacity.yaml"
sed -i "/path:\ \/spec\/pvPool\/resources\/requests\/storage/{ n; s/value: .*$/value: $CAPACITY/g }" noobaa/overlay/airgapped/kustomization.yaml

  #default storage
echo "-- Update default storage name --"
echo "File: noobaa/overlay/airgapped/kustomization.yaml"
sed -i "/path:\ \/spec\/multiCloudGateway\/dbStorageClassName/{ n; s/value: .*$/value: $DEFAULT_STORAGE/g }" noobaa/overlay/airgapped/kustomization.yaml
