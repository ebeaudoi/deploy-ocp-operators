#!/bin/bash

################################
# IMPORTANT                    #
# Update the 2 below variables #
CHANNEL="latest"
CATALOG="ebdn-redhat-operators"
# Backup the files
cp overlays/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}

######################
# Showing new values #
echo "-----------------------------"
echo "Channel = $CHANNEL"
echo "Catalog = $CATALOG"
echo "-----------------------------"

#####################################
# Update operator overlay yaml file #

  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: overlays/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $CHANNEL/g }" overlays/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: overlays/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CATALOG/g }" overlays/airgapped/kustomization.yaml

