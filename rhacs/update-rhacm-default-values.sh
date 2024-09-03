#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
RHCAS_CHANNEL="stable"
RHCAS_CATALOG="redhat-operators"
RHACS_OSE_CLI="registry.redhat.io/openshift4/ose-cli:latest"

# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp central-secure-instance/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
OSE_CLI=$( echo $RHACS_OSE_CLI|sed 's/\//\\\//g')

# Showing new values
echo "-----------------------------"
echo "Channel = $RHCAS_CHANNEL"
echo "Catalog = $RHCAS_CATALOG"
echo "OSE CLI = $OSE_CLI"
echo "-----------------------------"

#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $RHCAS_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RHCAS_CATALOG/g }" operator/overlay/airgapped/kustomization.yaml

##########################################
# Update central-secure-instance overlay yaml file #
  # Update the ose-cli from the private quay
echo
echo "-- Update central-secure-instance channel-- "
echo "File: central-secure-instance/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $RHCAS_CHANNEL/g }" central-secure-instance/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update central-secure-instance catalog --"
echo "File: central-secure-instance/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RHCAS_CATALOG/g }" central-secure-instance/overlay/airgapped/kustomization.yaml
echo "-- Update ose cli image --"
  # Upadte OSE CLI image
echo "File: central-secure-instance/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: $OSE_CLI/g }" central-secure-instance/overlay/airgapped/kustomization.yaml


