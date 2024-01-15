#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
#                              #
LOG_CHANNEL="stable-5.8"
LOKI_CHANNEL="stable-5.8"
CATALOG="cs-my-redhat-catalog"

####################
# Backup the files #
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp loki/operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}

######################
# Showing new values #
echo "-----------------------------"
echo "Logging channel = $LOG_CHANNEL"
echo "Loki channel = $LOKI_CHANNEL"
echo "Catalog = $CATALOG"
echo "OSE CLI = $OSE_CLI"
echo "-----------------------------"

#############################################
# Update logging operator overlay yaml file #
  # Update the logging subscription channel
echo
echo "-- Update logging operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $LOG_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the logging subscription catalog
echo "-- Update logging operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CATALOG/g }" operator/overlay/airgapped/kustomization.yaml
#############################################
# Update loki operator overlay yaml file #
  # Update the loki subscription channel
echo
echo "-- Update loki operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $LOKI_CHANNEL/g }" loki/operator/overlay/airgapped/kustomization.yaml
  # Update the loki subscription catalog
echo "-- Update loki operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $CATALOG/g }" loki/operator/overlay/airgapped/kustomization.yaml
