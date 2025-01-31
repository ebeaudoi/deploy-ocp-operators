#!/bin/bash
####################################################
#                                                  #
# Update all operators update scripts and run them #
# - UPDATE THIS SECTION ONLY                       #

## General variables ##
RHCATALOG="ebdn-redhat-operators"
OSE_CLI_IMAGE="registry\.redhat\.io\/openshift4\/ose-cli\@sha256\:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"
CERTCATALOG="my-certified-v413-catalog"

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

## RHACS ##
RHCASCHANNEL="stable"

## PIPELINE ##
PIPELINECHANNEL="latest"

## LOGGING ##
LOGCHANNEL="stable-5.8"
LOKICHANNEL="stable-5.8"
LOGSTORAGECLASS="storageclass"

## NUTANIX ##
NUTANIXCHANNEL="stable"
CERTCATALOG="my-redhat-v413-catalog"
PRISMISCSIIP="10.10.10.10"
PRISMSTORAGENAME="os-storage"
PRISMELLOGIN="10.10.17.90:9440:username:password"

## KIALI ##
KIALICHANNEL="stable"

## JAEGER ##
JAEGERCHANNEL="stable"

## ELASTICSEARCH ##
ELASTICSEARCHCHANNEL="stable-5.8"

################################
#    Backup all the files      #

#cp odf/update-odf-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhacm/update-rhacm-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp gitops/update-gitops-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp virt-operator/update-virt-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp servicemesh/update-servicemesh-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp serverless/update-serverless-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhods/update-rhods-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhacs/update-rhacm-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp pipelines-operator/update-pipeline-op-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp logging/update-logging-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp nutanix/update-nutanix-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp kiali/update-kiali-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp jaeger/update-jaeger-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
cp elasticsearch/update-elasticsearch-default-values.sh{,.$(date +%Y%m%d-%HH%M)}
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

#RHACS
echo "-- Modify RHACS Operator update script --"
echo "File: rhacs/update-rhacm-default-values.sh"
#RHCAS_CHANNEL
echo "Updating: RHCAS_CHANNEL=$RHCASCHANNEL"
sed -i "s/^RHCAS_CHANNEL.*$/RHCAS_CHANNEL=\"$RHCASCHANNEL\"/g" rhacs/update-rhacm-default-values.sh
#RHCAS_CATALOG
echo "Updating: RHCAS_CATALOG=$RHCATALOG"
sed -i "s/^RHCAS_CATALOG.*$/RHCAS_CATALOG=\"$RHCATALOG\"/g" rhacs/update-rhacm-default-values.sh
#RHACS_OSE_CLI
echo "Updating: RHACS_OSE_CLI_IMAGE=$OSE_CLI_IMAGE"
sed -i "s/^RHACS_OSE_CLI.*$/RHACS_OSE_CLI=\"$OSE_CLI_IMAGE\"/g" rhacs/update-rhacm-default-values.sh

## PIPELINE ##
echo "-- Modify pipeline Operator update script --"
echo "File: pipelines-operator/update-pipeline-op-default-values.sh"
#PIPELINECHANNEL
echo "Updating: Pipeline CHANNEL=$PIPELINECHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$PIPELINECHANNEL\"/g" pipelines-operator/update-pipeline-op-default-values.sh
#PIPELINECATALOG
echo "Updating: Pipeline CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" pipelines-operator/update-pipeline-op-default-values.sh

## LOGGING ##
echo "-- Modify Logging Operator update script --"
echo "File: logging/update-logging-default-values.sh"
#LOGGING CHANNEL
echo "Updating: Logging CHANNEL=$LOGCHANNEL"
sed -i "s/^LOG_CHANNEL.*$/LOG_CHANNEL=\"$LOGCHANNEL\"/g" logging/update-logging-default-values.sh
#LOGGING CATALOG
echo "Updating: Logging CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" logging/update-logging-default-values.sh
#LOGGING LOKI CHANNEL
echo "Updating: Logging LOKI CHANNEL=$LOKICHANNEL"
sed -i "s/^LOKI_CHANNEL.*$/LOKI_CHANNEL=\"$LOKICHANNEL\"/g" logging/update-logging-default-values.sh
#LOGGING STORAGE CLASS
echo "Updating: Logging STORAGECLASS=$LOGSTORAGECLASS"
sed -i "s/^STORAGECLASS.*$/STORAGECLASS=\"$LOGSTORAGECLASS\"/g" logging/update-logging-default-values.sh

# NUTANIX 
echo "-- Modify Nutanix Operator update script --"
echo "File: nutanix/update-nutanix-default-values.sh"
#NUTANIX CHANNEL
echo "Updating: Nutanix CHANNEL=$LOGCHANNEL"
sed -i "s/^NUTANIX_CHANNEL.*$/NUTANIX_CHANNEL=\"$NUTANIXCHANNEL\"/g" nutanix/update-nutanix-default-values.sh
#NUTANIX CATALOG
echo "Updating: Nutanix CATALOG=$RHCATALOG"
sed -i "s/^CERTCATALOG.*$/CERTCATALOG=\"$CERTCATALOG\"/g" nutanix/update-nutanix-default-values.sh
#NUTANIX PRISM_ISCSI_IP
echo "Updating: Nutanix PRISM_ISCSI_IP=$PRISMISCSIIP"
sed -i "s/^PRISM_ISCSI_IP.*$/PRISM_ISCSI_IP=\"$PRISMISCSIIP\"/g" nutanix/update-nutanix-default-values.sh
#NUTANIX STORAGE CLASS
echo "Updating: Nutanix PRISM_STORAGE_NAME=$PRISMSTORAGENAME"
sed -i "s/^PRISM_STORAGE_NAME.*$/PRISM_STORAGE_NAME=\"$PRISMSTORAGENAME\"/g" nutanix/update-nutanix-default-values.sh
#NUTANIX PRISM_EL_LOGIN
echo "Updating: Nutanix PRISM_EL_LOGIN=$PRISMELLOGIN"
sed -i "s/^PRISM_EL_LOGIN.*$/PRISM_EL_LOGIN=\"$PRISMELLOGIN\"/g" nutanix/update-nutanix-default-values.sh

## KIALI ##
echo "-- Modify Kiali Operator update script --"
echo "File: kiali/update-kiali-default-values.sh"
#KIALI_CHANNEL
echo "Updating: KIALI CHANNEL=$KIALICHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$KIALICHANNEL\"/g" kiali/update-kiali-default-values.sh
#KIALI_CATALOG
echo "Updating: KIALI CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" kiali/update-kiali-default-values.sh

## JAEGER ##
echo "-- Modify Jaeger Operator update script --"
echo "File: jaeger/update-jaeger-default-values.sh"
#JAEGER_CHANNEL
echo "Updating: JAEGER CHANNEL=$JAEGERCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$JAEGERCHANNEL\"/g" jaeger/update-jaeger-default-values.sh
#JAEGER_CATALOG
echo "Updating: JAEGER CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" jaeger/update-jaeger-default-values.sh


## ELASTICSEARCH ##
echo "-- Modify ELASTICSEARCH Operator update script --"
echo "File: elasticsearch/update-elasticsearch-default-values.sh"
#ELASTICSEARCH_CHANNEL
echo "Updating: ELASTICSEARCH CHANNEL=$ELASTICSEARCHCHANNEL"
sed -i "s/^CHANNEL.*$/CHANNEL=\"$ELASTICSEARCHCHANNEL\"/g" elasticsearch/update-elasticsearch-default-values.sh
#ELASTICSEARCH_CATALOG
echo "Updating: ELASTICSEARCH CATALOG=$RHCATALOG"
sed -i "s/^CATALOG.*$/CATALOG=\"$RHCATALOG\"/g" elasticsearch/update-elasticsearch-default-values.sh




