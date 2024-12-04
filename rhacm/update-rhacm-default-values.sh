#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
RHCAM_CHANNEL="release-2.12"
RHCAM_CATALOG="ebdn-redhat-operators"
RHACM_OSE_CLI="ebdn-registry.redhat.io/openshift4/ose-cli@sha256:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"

# Backup the files
cp operator/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp observability/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
cp instance/overlay/airgapped/kustomization.yaml{,.$(date +%Y%m%d-%HH%M)}
OSE_CLI=$( echo $RHACM_OSE_CLI|sed 's/\//\\\//g')
MCE_SUB_SPEC="\ \ \ \ \ \ \ \ \ installer\.open-cluster-management\.io\/mce-subscription-spec: \'\{\\\"source\\\": \\\"$RHCAM_CATALOG\\\"\}\'"
# Showing new values
echo "-----------------------------"
echo "Channel = $RHCAM_CHANNEL"
echo "Catalog = $RHCAM_CATALOG"
echo "OSE CLI = $OSE_CLI"
echo "-----------------------------"

#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
echo
echo "-- Update operator channel-- "
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo
sed -i "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $RHCAM_CHANNEL/g }" operator/overlay/airgapped/kustomization.yaml
  # Update the subscription catalog
echo "-- Update operator catalog --"
echo "File: operator/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RHCAM_CATALOG/g }" operator/overlay/airgapped/kustomization.yaml

##########################################
# Update Observability overlay yaml file #
  # Update the ose-cli from the private quay
echo "-- Update ose cli image --"
echo "File: observability/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: $OSE_CLI/g }" observability/overlay/airgapped/kustomization.yaml

######################################################
# Update MultiClusterHub overlay yaml file           #
  # Update the  mce-subscription-spec with RH catalog
echo "-- Update instance --"
echo "File: instance/overlay/airgapped/kustomization.yaml"
echo ""
sed -i "/.*mce-subscription-spec.*/c $MCE_SUB_SPEC" instance/overlay/airgapped/kustomization.yaml


