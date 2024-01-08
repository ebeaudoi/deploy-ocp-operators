#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
CHANNEL="stable-4.14"
CATALOG="cs-my-redhat-catalog"
OSE_CLI_IMAGE="quay.devu.ca:8443/redhat-v414/openshift4/ose-cli:e11912cb"
CAPACITY="150Gi"

# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp noobaa/overlay/default/patch-storage-capacity.yaml{,.$(date +%Y%m%d-%HH%M)}
OSE_CLI=$( echo $OSE_CLI_IMAGE |sed 's/\//\\\//g')
# Showing new values
echo "-----------------------------"
echo "Channel = $CHANNEL"
echo "Catalog = $CATALOG"
echo "OSE CLI = $OSE_CLI"
echo "CAPACITY = $CAPACITY"
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
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CATALOG/g }" operator/overlay/airgapped/kustomization.yaml
  # Update image to enable console
echo "-- Update ose cli image --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: $OSE_CLI/g }" operator/overlay/airgapped/kustomization.yaml

####################################
# Update Stroage capacity          #
echo "-- Update storage capacity --"
echo "File: noobaa/overlay/default/patch-storage-capacity.yaml"
sed -i "/path:\ \/spec\/pvPool\/resources\/requests\/storage/{ n; s/value: .*$/value: $CAPACITY/g }" noobaa/overlay/default/patch-storage-capacity.yaml
