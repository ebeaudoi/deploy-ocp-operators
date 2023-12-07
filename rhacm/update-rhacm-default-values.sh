#!/bin/bash

################################
# IMPORTANT                    #
# Update the 3 below variables #
RHCAM_CHANNEL="release-2.8"
RHCAM_CATALOG="my-redhat-v413-catalog"
RHACM_OSE_CLI="ebdnquay.ebdnlab.vmware.tamlab.rdu2.redhat.com:8443/redhat-v413/openshift4/ose-cli:e11912cb"

#####################################
# Update operator overlay yaml file #
  # Update the subscription channel
sed "/path:\ \/spec\/channel/{ n; s/value: .*$/value: $RHCAM_CHANNEL/g }" operator/overlays/airgapped/kustomization.yaml
  # Update the subscription catalog
sed "/path:\ \/spec\/source/{ n; s/value: .*$/value: $RHCAM_CATALOG/g }" operator/overlays/airgapped/kustomization.yaml

##########################################
# Update Observability overlay yaml file #
  # Update the ose-cli from the private quay
sed "/path:\ \/spec\/template\/spec\/containers\/0\/image/{ n; s/value: .*$/value: $RHACM_OSE_CLI/g }" observability/overlay/airgapped/kustomization.yaml

######################################################
# Update MultiClusterHub overlay yaml file           #
  # Update the  mce-subscription-spec with RH catalog
sed "/path:\ \/metadata\/annotations\/installer\.open-cluster-management\.io\/mce-subscription-spec/{ n; s/value: .*$/value:\ \'\{\"source\": \"$RHCAM_CATALOG\"\}\'/g }" instance/overlay/airgapped/kustomization.yaml
