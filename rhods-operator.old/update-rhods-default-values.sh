#!/bin/bash

################################
# IMPORTANT                    #
# Update the 2 below variables #
RHODS_CHANNEL="stable"
RH_CATALOG="cs-my-redhat-catalog"

# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}

# Showing new values
echo "-----------------------------"
echo "Channel = $RHODS_CHANNEL"
echo "Catalog = $RH_CATALOG"
echo "-----------------------------"

#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $RHODS_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RH_CATALOG/g }" operator/overlay/airgapped/kustomization.yaml

