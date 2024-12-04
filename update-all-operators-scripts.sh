#!/bin/bash
####################################################
#                                                  #
# Update all operators update scripts and run them #
# - UPDATE THIS SECTION ONLY                       #

## General variables ##
RHCATALOG="ebdn-redhat-operators"
OSE_CLI_IMAGE="registry\.redhat\.io\/openshift4\/ose-cli\@sha256\:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"

## ODF operators ##
ODFCHANNEL="stable-4.17"
ODFCAPACITY="300Gi"
ODFDEFAULT_STORAGE="thin-csi"

## RHACM ##
RHCAMCHANNEL="release-2.12"

## GITOPS ##
GITOPSCHANNEL="latest"

## VIRT ##
VIRTCHANNEL="stable"

## SERVICEMESH ##
SMESHCHANNEL="stable"
SMESHCSV="servicemeshoperator.v2.4.5"

## SERVERLESS ##
SLESSCHANNEL="stable"

## RHODS ##
RHODSCHANNEL="stable"

################################
#    Backup all the files      #

#cp odf/update-odf-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhacm/update-rhacm-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp gitops/update-gitops-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp virt-operator/update-virt-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp servicemesh/update-servicemesh-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp serverless/update-serverless-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
cp rhods/update-rhods-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
################################
#    Modify all the files      #
#ODF
echo "-- Modify ODF Operator update script --"
echo "File: odf/update-odf-default-values.sh"
#ODF RHCATALOG
echo "Updating: RHCATALOG=$RHCATALOG"
sed -i "s/^RHCATALOG.*$/RHCATALOG=\"$RHCATALOG\"/g" odf/update-odf-default-values.sh
#ODF OSE_CLI_IMAGE
echo "Updating: OSE_CLI_IMAGE=$OSE_CLI_IMAGE"
sed -i "s/^OSE_CLI_IMAGE.*$/OSE_CLI_IMAGE=\"$OSE_CLI_IMAGE\"/g" odf/update-odf-default-values.sh
#ODF CHANNEL
echo "Updating: ODFCHANNEL=$ODFCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$ODFCHANNEL\"/g" odf/update-odf-default-values.sh
#ODF CAPACITY
echo "Updating: CAPACITY=$ODFCAPACITY"
sed -i "s/^CAPACITY.*$/CAPACITY=\"$ODFCAPACITY\"/g" odf/update-odf-default-values.sh
#ODF DEFAULT_STORAGE
echo "Updating: DEFAULT_STORAGE=$ODFDEFAULT_STORAGE"
sed -i "s/^DEFAULT_STORAGE.*$/DEFAULT_STORAGE=\"$ODFDEFAULT_STORAGE\"/g" odf/update-odf-default-values.sh

#RHACM
echo "-- Modify RHACM Operator update script --"
echo "File: rhacm/update-rhacm-default-values.sh"
#RHCAM_CHANNEL
echo "Updating: RHCAM_CHANNEL=$RHCAMCHANNEL"
sed -i "s/^RHCAM_CHANNEL.*$/RHCAM_CHANNEL=\"$RHCAMCHANNEL\"/g" rhacm/update-rhacm-default-values.sh
#RHCAM_CATALOG
echo "Updating: RHCAM_CATALOG=$RHCATALOG"
sed -i "s/^RHCAM_CATALOG.*$/RHCAM_CATALOG=\"$RHCATALOG\"/g" rhacm/update-rhacm-default-values.sh
#RHACM_OSE_CLI
echo "Updating: RHACM_OSE_CLI_IMAGE=$OSE_CLI_IMAGE"
sed -i "s/^RHACM_OSE_CLI.*$/RHACM_OSE_CLI=\"$OSE_CLI_IMAGE\"/g" rhacm/update-rhacm-default-values.sh

#GITOSP
echo "-- Modify GITOSP Operator update script --"
echo "File: gitops/update-gitops-default-values.sh"
#GITOPS_CHANNEL
echo "Updating: GITOPS CHANNEL=$GITOPSCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$GITOPSCHANNEL\"/g" gitops/update-gitops-default-values.sh
#GITOPS_CATALOG
echo "Updating: GITOPS CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" gitops/update-gitops-default-values.sh

#VIRT
echo "-- Modify VIRT Operator update script --"
echo "File: virt-operator/update-virt-default-values.sh"
#VIRT_CHANNEL
echo "Updating: VIRT CHANNEL=$VIRTCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$VIRTCHANNEL\"/g" virt-operator/update-virt-default-values.sh
#VIRT_CATALOG
echo "Updating: VIRT CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" virt-operator/update-virt-default-values.sh

#SERVICE MESH
echo "-- Modify ServiceMesh Operator update script --"
echo "File: servicemesh/update-servicemesh-default-values.sh"
#SMESH_CHANNEL
echo "Updating: ServiceMesh CHANNEL=$SMESHCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$SMESHCHANNEL\"/g" servicemesh/update-servicemesh-default-values.sh
#SMESH_CATALOG
echo "Updating: ServiceMesh CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" servicemesh/update-servicemesh-default-values.sh
#SMESH_CSV
echo "Updating: ServiceMesh CSV=$SMESHCSV"
sed -i "s/^CSV.*$/CSV=\"$SMESHCSV\"/g" servicemesh/update-servicemesh-default-values.sh

## SERVERLESS ##
echo "-- Modify Serverless Operator update script --"
echo "File: serverless/update-serverless-default-values.sh"
#SLESS_CHANNEL
echo "Updating: Serviceless CHANNEL=$SLESSCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$SLESSCHANNEL\"/g" serverless/update-serverless-default-values.sh
#SLESS_CATALOG
echo "Updating: Serviceless CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" serverless/update-serverless-default-values.sh


## RHODS ##
echo "-- Modify RH ODS Operator update script --"
echo "File: rhods/update-rhods-default-values.sh"
#SLESS_CHANNEL
echo "Updating: RHODS CHANNEL=$RHODSCHANNEL"
sed -i "s/^RHODS_CHANNEL.*$/RHODS_CHANNEL=\"$RHODSCHANNEL\"/g" rhods/update-rhods-default-values.sh
#SLESS_CATALOG
echo "Updating: RHODS CATALOG=$RHCATALOG"
sed -i "s/^RH_CATALOG.*$/RH_CATALOG=\"$RHCATALOG\"/g" rhods/update-rhods-default-values.sh



