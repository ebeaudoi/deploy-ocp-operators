#!/bin/bash
####################################################
#                                                  #
# Update all operators update scripts and run them #
# - UPDATE THIS SECTION ONLY                       #
####################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counters
TOTAL_OPERATORS=0
SUCCESSFUL_UPDATES=0
FAILED_UPDATES=0

# Function to print section header
print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}"
}

# Function to print operator section
print_operator() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Function to print update message
print_update() {
    echo -e "  ${GREEN}✓${NC} $1"
}

# Function to print error message
print_error() {
    echo -e "  ${RED}✗${NC} $1"
    FAILED_UPDATES=$((FAILED_UPDATES + 1))
}

# Function to check if file exists
check_file() {
    if [ ! -f "$1" ]; then
        print_error "File not found: $1"
        return 1
    fi
    return 0
}

# Start script
clear
print_header "Operator Update Script Orchestrator"
echo -e "${YELLOW}Started at: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo ""

################################
#  Standardized Variables      #
#  UPPER_SNAKE_CASE Convention #
################################

## Shared/Common Variables ##
REDHAT_CATALOG_SOURCE="ebdn-redhat-operators"
CERTIFIED_CATALOG_SOURCE="my-certified-v413-catalog"
OSE_CLI_IMAGE="registry\.redhat\.io\/openshift4\/ose-cli\@sha256\:3b288bdf503733042786c07ab23ba344c8ad98a38717c192584d0e1926ae9758"

## ODF Operator Variables ##
ODF_SUBSCRIPTION_CHANNEL="stable-4.17"
ODF_STORAGE_CAPACITY="300Gi"
ODF_DEFAULT_STORAGE_CLASS="thin-csi"

## RHACM Operator Variables ##
RHACM_SUBSCRIPTION_CHANNEL="release-2.12"

## GitOps Operator Variables ##
GITOPS_SUBSCRIPTION_CHANNEL="latest"

## Virtualization Operator Variables ##
VIRT_OPERATOR_SUBSCRIPTION_CHANNEL="stable"

## Service Mesh Operator Variables ##
SERVICEMESH_SUBSCRIPTION_CHANNEL="stable"
SERVICEMESH_STARTING_CSV="servicemeshoperator.v2.4.5"

## Serverless Operator Variables ##
SERVERLESS_SUBSCRIPTION_CHANNEL="stable"

## RHODS Operator Variables ##
RHODS_SUBSCRIPTION_CHANNEL="stable"

## RHACS Operator Variables ##
RHACS_SUBSCRIPTION_CHANNEL="stable"

## Pipelines Operator Variables ##
PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL="latest"

## Logging Operator Variables ##
LOGGING_SUBSCRIPTION_CHANNEL="stable-5.8"
LOKI_SUBSCRIPTION_CHANNEL="stable-5.8"
LOGGING_STORAGE_CLASS="storageclass"

## Nutanix Operator Variables ##
NUTANIX_SUBSCRIPTION_CHANNEL="stable"
NUTANIX_CERTIFIED_CATALOG_SOURCE="my-redhat-v413-catalog"
NUTANIX_PRISM_ISCSI_IP="10.10.10.10"
NUTANIX_PRISM_STORAGE_NAME="os-storage"
NUTANIX_PRISM_ELEMENT_LOGIN="10.10.17.90:9440:username:password"

## Kiali Operator Variables ##
KIALI_SUBSCRIPTION_CHANNEL="stable"

## Jaeger Operator Variables ##
JAEGER_SUBSCRIPTION_CHANNEL="stable"

## Elasticsearch Operator Variables ##
ELASTICSEARCH_SUBSCRIPTION_CHANNEL="stable-5.8"

## NFD Operator Variables ##
NFD_SUBSCRIPTION_CHANNEL="stable"

## LVM Storage Operator Variables ##
LVM_STORAGE_SUBSCRIPTION_CHANNEL="stable"

## Local Storage Operator Variables ##
LOCAL_STORAGE_SUBSCRIPTION_CHANNEL="stable"

## OADP Operator Variables ##
OADP_SUBSCRIPTION_CHANNEL="ebdnlatest"

################################
#    Backup all the files      #
################################
# Note: Uncomment backup lines below if you want to backup scripts before modification
#cp odf/update-odf-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhacm/update-rhacm-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp gitops/update-gitops-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp virt-operator/update-virt-operator-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp servicemesh/update-servicemesh-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp serverless/update-serverless-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhods/update-rhods-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp rhacs/update-rhacs-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp pipelines-operator/update-pipelines-operator-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp logging/update-logging-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp nutanix/update-nutanix-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp kiali/update-kiali-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp jaeger/update-jaeger-values.sh{,.$(date +%Y%m%d-%HH%M)}
#cp elasticsearch/update-elasticsearch-values.sh{,.$(date +%Y%m%d-%HH%M)}

################################
#    Modify all the files      #
################################

#ODF
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "ODF Operator"
if check_file "odf/update-odf-values.sh"; then
    print_update "File: odf/update-odf-values.sh"
    sed -i "s|^ODF_CATALOG_SOURCE=.*$|ODF_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" odf/update-odf-values.sh && print_update "ODF_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update ODF_CATALOG_SOURCE"
    sed -i "s|^ODF_OSE_CLI_IMAGE=.*$|ODF_OSE_CLI_IMAGE=\"$OSE_CLI_IMAGE\"|g" odf/update-odf-values.sh && print_update "ODF_OSE_CLI_IMAGE updated" || print_error "Failed to update ODF_OSE_CLI_IMAGE"
    sed -i "s|^ODF_SUBSCRIPTION_CHANNEL=.*$|ODF_SUBSCRIPTION_CHANNEL=\"$ODF_SUBSCRIPTION_CHANNEL\"|g" odf/update-odf-values.sh && print_update "ODF_SUBSCRIPTION_CHANNEL=$ODF_SUBSCRIPTION_CHANNEL" || print_error "Failed to update ODF_SUBSCRIPTION_CHANNEL"
    sed -i "s|^ODF_STORAGE_CAPACITY=.*$|ODF_STORAGE_CAPACITY=\"$ODF_STORAGE_CAPACITY\"|g" odf/update-odf-values.sh && print_update "ODF_STORAGE_CAPACITY=$ODF_STORAGE_CAPACITY" || print_error "Failed to update ODF_STORAGE_CAPACITY"
    sed -i "s|^ODF_DEFAULT_STORAGE_CLASS=.*$|ODF_DEFAULT_STORAGE_CLASS=\"$ODF_DEFAULT_STORAGE_CLASS\"|g" odf/update-odf-values.sh && print_update "ODF_DEFAULT_STORAGE_CLASS=$ODF_DEFAULT_STORAGE_CLASS" || print_error "Failed to update ODF_DEFAULT_STORAGE_CLASS"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

#RHACM
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "RHACM Operator"
if check_file "rhacm/update-rhacm-values.sh"; then
    print_update "File: rhacm/update-rhacm-values.sh"
    sed -i "s|^RHACM_SUBSCRIPTION_CHANNEL=.*$|RHACM_SUBSCRIPTION_CHANNEL=\"$RHACM_SUBSCRIPTION_CHANNEL\"|g" rhacm/update-rhacm-values.sh && print_update "RHACM_SUBSCRIPTION_CHANNEL=$RHACM_SUBSCRIPTION_CHANNEL" || print_error "Failed to update RHACM_SUBSCRIPTION_CHANNEL"
    sed -i "s|^RHACM_CATALOG_SOURCE=.*$|RHACM_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" rhacm/update-rhacm-values.sh && print_update "RHACM_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update RHACM_CATALOG_SOURCE"
    sed -i "s|^RHACM_OSE_CLI_IMAGE=.*$|RHACM_OSE_CLI_IMAGE=\"$OSE_CLI_IMAGE\"|g" rhacm/update-rhacm-values.sh && print_update "RHACM_OSE_CLI_IMAGE updated" || print_error "Failed to update RHACM_OSE_CLI_IMAGE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

#GITOPS
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "GitOps Operator"
if check_file "gitops/update-gitops-values.sh"; then
    print_update "File: gitops/update-gitops-values.sh"
    sed -i "s|^GITOPS_SUBSCRIPTION_CHANNEL=.*$|GITOPS_SUBSCRIPTION_CHANNEL=\"$GITOPS_SUBSCRIPTION_CHANNEL\"|g" gitops/update-gitops-values.sh && print_update "GITOPS_SUBSCRIPTION_CHANNEL=$GITOPS_SUBSCRIPTION_CHANNEL" || print_error "Failed to update GITOPS_SUBSCRIPTION_CHANNEL"
    sed -i "s|^GITOPS_CATALOG_SOURCE=.*$|GITOPS_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" gitops/update-gitops-values.sh && print_update "GITOPS_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update GITOPS_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

#VIRT
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Virtualization Operator"
if check_file "virt-operator/update-virt-operator-values.sh"; then
    print_update "File: virt-operator/update-virt-operator-values.sh"
    sed -i "s|^VIRT_OPERATOR_SUBSCRIPTION_CHANNEL=.*$|VIRT_OPERATOR_SUBSCRIPTION_CHANNEL=\"$VIRT_OPERATOR_SUBSCRIPTION_CHANNEL\"|g" virt-operator/update-virt-operator-values.sh && print_update "VIRT_OPERATOR_SUBSCRIPTION_CHANNEL=$VIRT_OPERATOR_SUBSCRIPTION_CHANNEL" || print_error "Failed to update VIRT_OPERATOR_SUBSCRIPTION_CHANNEL"
    sed -i "s|^VIRT_OPERATOR_CATALOG_SOURCE=.*$|VIRT_OPERATOR_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" virt-operator/update-virt-operator-values.sh && print_update "VIRT_OPERATOR_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update VIRT_OPERATOR_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

#SERVICE MESH
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Service Mesh Operator"
if check_file "servicemesh/update-servicemesh-values.sh"; then
    print_update "File: servicemesh/update-servicemesh-values.sh"
    sed -i "s|^SERVICEMESH_SUBSCRIPTION_CHANNEL=.*$|SERVICEMESH_SUBSCRIPTION_CHANNEL=\"$SERVICEMESH_SUBSCRIPTION_CHANNEL\"|g" servicemesh/update-servicemesh-values.sh && print_update "SERVICEMESH_SUBSCRIPTION_CHANNEL=$SERVICEMESH_SUBSCRIPTION_CHANNEL" || print_error "Failed to update SERVICEMESH_SUBSCRIPTION_CHANNEL"
    sed -i "s|^SERVICEMESH_CATALOG_SOURCE=.*$|SERVICEMESH_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" servicemesh/update-servicemesh-values.sh && print_update "SERVICEMESH_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update SERVICEMESH_CATALOG_SOURCE"
    sed -i "s|^SERVICEMESH_STARTING_CSV=.*$|SERVICEMESH_STARTING_CSV=\"$SERVICEMESH_STARTING_CSV\"|g" servicemesh/update-servicemesh-values.sh && print_update "SERVICEMESH_STARTING_CSV=$SERVICEMESH_STARTING_CSV" || print_error "Failed to update SERVICEMESH_STARTING_CSV"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## SERVERLESS ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Serverless Operator"
if check_file "serverless/update-serverless-values.sh"; then
    print_update "File: serverless/update-serverless-values.sh"
    sed -i "s|^SERVERLESS_SUBSCRIPTION_CHANNEL=.*$|SERVERLESS_SUBSCRIPTION_CHANNEL=\"$SERVERLESS_SUBSCRIPTION_CHANNEL\"|g" serverless/update-serverless-values.sh && print_update "SERVERLESS_SUBSCRIPTION_CHANNEL=$SERVERLESS_SUBSCRIPTION_CHANNEL" || print_error "Failed to update SERVERLESS_SUBSCRIPTION_CHANNEL"
    sed -i "s|^SERVERLESS_CATALOG_SOURCE=.*$|SERVERLESS_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" serverless/update-serverless-values.sh && print_update "SERVERLESS_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update SERVERLESS_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi


## RHODS ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "RHODS (OpenShift Data Science) Operator"
if check_file "rhods/update-rhods-values.sh"; then
    print_update "File: rhods/update-rhods-values.sh"
    sed -i "s|^RHODS_SUBSCRIPTION_CHANNEL=.*$|RHODS_SUBSCRIPTION_CHANNEL=\"$RHODS_SUBSCRIPTION_CHANNEL\"|g" rhods/update-rhods-values.sh && print_update "RHODS_SUBSCRIPTION_CHANNEL=$RHODS_SUBSCRIPTION_CHANNEL" || print_error "Failed to update RHODS_SUBSCRIPTION_CHANNEL"
    sed -i "s|^RHODS_CATALOG_SOURCE=.*$|RHODS_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" rhods/update-rhods-values.sh && print_update "RHODS_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update RHODS_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

#RHACS
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "RHACS (Advanced Cluster Security) Operator"
if check_file "rhacs/update-rhacs-values.sh"; then
    print_update "File: rhacs/update-rhacs-values.sh"
    sed -i "s|^RHACS_SUBSCRIPTION_CHANNEL=.*$|RHACS_SUBSCRIPTION_CHANNEL=\"$RHACS_SUBSCRIPTION_CHANNEL\"|g" rhacs/update-rhacs-values.sh && print_update "RHACS_SUBSCRIPTION_CHANNEL=$RHACS_SUBSCRIPTION_CHANNEL" || print_error "Failed to update RHACS_SUBSCRIPTION_CHANNEL"
    sed -i "s|^RHACS_CATALOG_SOURCE=.*$|RHACS_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" rhacs/update-rhacs-values.sh && print_update "RHACS_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update RHACS_CATALOG_SOURCE"
    sed -i "s|^RHACS_OSE_CLI_IMAGE=.*$|RHACS_OSE_CLI_IMAGE=\"$OSE_CLI_IMAGE\"|g" rhacs/update-rhacs-values.sh && print_update "RHACS_OSE_CLI_IMAGE updated" || print_error "Failed to update RHACS_OSE_CLI_IMAGE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## PIPELINE ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Pipelines Operator"
if check_file "pipelines-operator/update-pipelines-operator-values.sh"; then
    print_update "File: pipelines-operator/update-pipelines-operator-values.sh"
    sed -i "s|^PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL=.*$|PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL=\"$PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL\"|g" pipelines-operator/update-pipelines-operator-values.sh && print_update "PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL=$PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL" || print_error "Failed to update PIPELINES_OPERATOR_SUBSCRIPTION_CHANNEL"
    sed -i "s|^PIPELINES_OPERATOR_CATALOG_SOURCE=.*$|PIPELINES_OPERATOR_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" pipelines-operator/update-pipelines-operator-values.sh && print_update "PIPELINES_OPERATOR_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update PIPELINES_OPERATOR_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## LOGGING ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Logging Operator"
if check_file "logging/update-logging-values.sh"; then
    print_update "File: logging/update-logging-values.sh"
    sed -i "s|^LOGGING_SUBSCRIPTION_CHANNEL=.*$|LOGGING_SUBSCRIPTION_CHANNEL=\"$LOGGING_SUBSCRIPTION_CHANNEL\"|g" logging/update-logging-values.sh && print_update "LOGGING_SUBSCRIPTION_CHANNEL=$LOGGING_SUBSCRIPTION_CHANNEL" || print_error "Failed to update LOGGING_SUBSCRIPTION_CHANNEL"
    sed -i "s|^LOGGING_CATALOG_SOURCE=.*$|LOGGING_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" logging/update-logging-values.sh && print_update "LOGGING_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update LOGGING_CATALOG_SOURCE"
    sed -i "s|^LOKI_SUBSCRIPTION_CHANNEL=.*$|LOKI_SUBSCRIPTION_CHANNEL=\"$LOKI_SUBSCRIPTION_CHANNEL\"|g" logging/update-logging-values.sh && print_update "LOKI_SUBSCRIPTION_CHANNEL=$LOKI_SUBSCRIPTION_CHANNEL" || print_error "Failed to update LOKI_SUBSCRIPTION_CHANNEL"
    sed -i "s|^LOGGING_STORAGE_CLASS=.*$|LOGGING_STORAGE_CLASS=\"$LOGGING_STORAGE_CLASS\"|g" logging/update-logging-values.sh && print_update "LOGGING_STORAGE_CLASS=$LOGGING_STORAGE_CLASS" || print_error "Failed to update LOGGING_STORAGE_CLASS"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

# NUTANIX 
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Nutanix Operator"
if check_file "nutanix/update-nutanix-values.sh"; then
    print_update "File: nutanix/update-nutanix-values.sh"
    sed -i "s|^NUTANIX_SUBSCRIPTION_CHANNEL=.*$|NUTANIX_SUBSCRIPTION_CHANNEL=\"$NUTANIX_SUBSCRIPTION_CHANNEL\"|g" nutanix/update-nutanix-values.sh && print_update "NUTANIX_SUBSCRIPTION_CHANNEL=$NUTANIX_SUBSCRIPTION_CHANNEL" || print_error "Failed to update NUTANIX_SUBSCRIPTION_CHANNEL"
    sed -i "s|^NUTANIX_CERTIFIED_CATALOG_SOURCE=.*$|NUTANIX_CERTIFIED_CATALOG_SOURCE=\"$NUTANIX_CERTIFIED_CATALOG_SOURCE\"|g" nutanix/update-nutanix-values.sh && print_update "NUTANIX_CERTIFIED_CATALOG_SOURCE=$NUTANIX_CERTIFIED_CATALOG_SOURCE" || print_error "Failed to update NUTANIX_CERTIFIED_CATALOG_SOURCE"
    sed -i "s|^NUTANIX_PRISM_ISCSI_IP=.*$|NUTANIX_PRISM_ISCSI_IP=\"$NUTANIX_PRISM_ISCSI_IP\"|g" nutanix/update-nutanix-values.sh && print_update "NUTANIX_PRISM_ISCSI_IP=$NUTANIX_PRISM_ISCSI_IP" || print_error "Failed to update NUTANIX_PRISM_ISCSI_IP"
    sed -i "s|^NUTANIX_PRISM_STORAGE_NAME=.*$|NUTANIX_PRISM_STORAGE_NAME=\"$NUTANIX_PRISM_STORAGE_NAME\"|g" nutanix/update-nutanix-values.sh && print_update "NUTANIX_PRISM_STORAGE_NAME=$NUTANIX_PRISM_STORAGE_NAME" || print_error "Failed to update NUTANIX_PRISM_STORAGE_NAME"
    sed -i "s|^NUTANIX_PRISM_ELEMENT_LOGIN=.*$|NUTANIX_PRISM_ELEMENT_LOGIN=\"$NUTANIX_PRISM_ELEMENT_LOGIN\"|g" nutanix/update-nutanix-values.sh && print_update "NUTANIX_PRISM_ELEMENT_LOGIN updated" || print_error "Failed to update NUTANIX_PRISM_ELEMENT_LOGIN"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## KIALI ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Kiali Operator"
if check_file "kiali/update-kiali-values.sh"; then
    print_update "File: kiali/update-kiali-values.sh"
    sed -i "s|^KIALI_SUBSCRIPTION_CHANNEL=.*$|KIALI_SUBSCRIPTION_CHANNEL=\"$KIALI_SUBSCRIPTION_CHANNEL\"|g" kiali/update-kiali-values.sh && print_update "KIALI_SUBSCRIPTION_CHANNEL=$KIALI_SUBSCRIPTION_CHANNEL" || print_error "Failed to update KIALI_SUBSCRIPTION_CHANNEL"
    sed -i "s|^KIALI_CATALOG_SOURCE=.*$|KIALI_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" kiali/update-kiali-values.sh && print_update "KIALI_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update KIALI_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## JAEGER ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Jaeger Operator"
if check_file "jaeger/update-jaeger-values.sh"; then
    print_update "File: jaeger/update-jaeger-values.sh"
    sed -i "s|^JAEGER_SUBSCRIPTION_CHANNEL=.*$|JAEGER_SUBSCRIPTION_CHANNEL=\"$JAEGER_SUBSCRIPTION_CHANNEL\"|g" jaeger/update-jaeger-values.sh && print_update "JAEGER_SUBSCRIPTION_CHANNEL=$JAEGER_SUBSCRIPTION_CHANNEL" || print_error "Failed to update JAEGER_SUBSCRIPTION_CHANNEL"
    sed -i "s|^JAEGER_CATALOG_SOURCE=.*$|JAEGER_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" jaeger/update-jaeger-values.sh && print_update "JAEGER_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update JAEGER_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi


## ELASTICSEARCH ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Elasticsearch Operator"
if check_file "elasticsearch/update-elasticsearch-values.sh"; then
    print_update "File: elasticsearch/update-elasticsearch-values.sh"
    sed -i "s|^ELASTICSEARCH_SUBSCRIPTION_CHANNEL=.*$|ELASTICSEARCH_SUBSCRIPTION_CHANNEL=\"$ELASTICSEARCH_SUBSCRIPTION_CHANNEL\"|g" elasticsearch/update-elasticsearch-values.sh && print_update "ELASTICSEARCH_SUBSCRIPTION_CHANNEL=$ELASTICSEARCH_SUBSCRIPTION_CHANNEL" || print_error "Failed to update ELASTICSEARCH_SUBSCRIPTION_CHANNEL"
    sed -i "s|^ELASTICSEARCH_CATALOG_SOURCE=.*$|ELASTICSEARCH_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" elasticsearch/update-elasticsearch-values.sh && print_update "ELASTICSEARCH_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update ELASTICSEARCH_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## NFD ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "NFD (Node Feature Discovery) Operator"
if check_file "nfd/update-nfd-values.sh"; then
    print_update "File: nfd/update-nfd-values.sh"
    sed -i "s|^NFD_SUBSCRIPTION_CHANNEL=.*$|NFD_SUBSCRIPTION_CHANNEL=\"$NFD_SUBSCRIPTION_CHANNEL\"|g" nfd/update-nfd-values.sh && print_update "NFD_SUBSCRIPTION_CHANNEL=$NFD_SUBSCRIPTION_CHANNEL" || print_error "Failed to update NFD_SUBSCRIPTION_CHANNEL"
    sed -i "s|^NFD_CATALOG_SOURCE=.*$|NFD_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" nfd/update-nfd-values.sh && print_update "NFD_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update NFD_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## LVM STORAGE ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "LVM Storage Operator"
if check_file "lvm-storage/update-lvm-storage-values.sh"; then
    print_update "File: lvm-storage/update-lvm-storage-values.sh"
    sed -i "s|^LVM_STORAGE_SUBSCRIPTION_CHANNEL=.*$|LVM_STORAGE_SUBSCRIPTION_CHANNEL=\"$LVM_STORAGE_SUBSCRIPTION_CHANNEL\"|g" lvm-storage/update-lvm-storage-values.sh && print_update "LVM_STORAGE_SUBSCRIPTION_CHANNEL=$LVM_STORAGE_SUBSCRIPTION_CHANNEL" || print_error "Failed to update LVM_STORAGE_SUBSCRIPTION_CHANNEL"
    sed -i "s|^LVM_STORAGE_CATALOG_SOURCE=.*$|LVM_STORAGE_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" lvm-storage/update-lvm-storage-values.sh && print_update "LVM_STORAGE_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update LVM_STORAGE_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## LOCAL STORAGE ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "Local Storage Operator"
if check_file "local-storage/update-local-storage-values.sh"; then
    print_update "File: local-storage/update-local-storage-values.sh"
    sed -i "s|^LOCAL_STORAGE_SUBSCRIPTION_CHANNEL=.*$|LOCAL_STORAGE_SUBSCRIPTION_CHANNEL=\"$LOCAL_STORAGE_SUBSCRIPTION_CHANNEL\"|g" local-storage/update-local-storage-values.sh && print_update "LOCAL_STORAGE_SUBSCRIPTION_CHANNEL=$LOCAL_STORAGE_SUBSCRIPTION_CHANNEL" || print_error "Failed to update LOCAL_STORAGE_SUBSCRIPTION_CHANNEL"
    sed -i "s|^LOCAL_STORAGE_CATALOG_SOURCE=.*$|LOCAL_STORAGE_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" local-storage/update-local-storage-values.sh && print_update "LOCAL_STORAGE_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update LOCAL_STORAGE_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

## OADP ##
TOTAL_OPERATORS=$((TOTAL_OPERATORS + 1))
print_operator "OADP (OpenShift API for Data Protection) Operator"
if check_file "openshift-api-for-data-protection-operator/update-oadp-values.sh"; then
    print_update "File: openshift-api-for-data-protection-operator/update-oadp-values.sh"
    sed -i "s|^OADP_SUBSCRIPTION_CHANNEL=.*$|OADP_SUBSCRIPTION_CHANNEL=\"$OADP_SUBSCRIPTION_CHANNEL\"|g" openshift-api-for-data-protection-operator/update-oadp-values.sh && print_update "OADP_SUBSCRIPTION_CHANNEL=$OADP_SUBSCRIPTION_CHANNEL" || print_error "Failed to update OADP_SUBSCRIPTION_CHANNEL"
    sed -i "s|^OADP_CATALOG_SOURCE=.*$|OADP_CATALOG_SOURCE=\"$REDHAT_CATALOG_SOURCE\"|g" openshift-api-for-data-protection-operator/update-oadp-values.sh && print_update "OADP_CATALOG_SOURCE=$REDHAT_CATALOG_SOURCE" || print_error "Failed to update OADP_CATALOG_SOURCE"
    SUCCESSFUL_UPDATES=$((SUCCESSFUL_UPDATES + 1))
fi

################################
#    Summary                   #
################################
echo ""
print_header "Update Summary"
echo -e "  ${CYAN}Total Operators Processed:${NC} $TOTAL_OPERATORS"
echo -e "  ${GREEN}Successful Updates:${NC}      $SUCCESSFUL_UPDATES"
if [ $FAILED_UPDATES -gt 0 ]; then
    echo -e "  ${RED}Failed Updates:${NC}         $FAILED_UPDATES"
else
    echo -e "  ${GREEN}Failed Updates:${NC}         $FAILED_UPDATES"
fi
echo ""
echo -e "${YELLOW}Completed at: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo ""

if [ $FAILED_UPDATES -eq 0 ]; then
    echo -e "${GREEN}✓ All operators updated successfully!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some operators failed to update. Please review the errors above.${NC}"
    exit 1
fi




