#!/bin/bash

BUCKET_HOST=$(oc get -n openshift-logging configmap loki-bucket-odf -o jsonpath='{.data.BUCKET_HOST}')
BUCKET_NAME=$(oc get -n openshift-logging configmap loki-bucket-odf -o jsonpath='{.data.BUCKET_NAME}')
BUCKET_PORT=$(oc get -n openshift-logging configmap loki-bucket-odf -o jsonpath='{.data.BUCKET_PORT}')

ACCESS_KEY_ID=$(oc get -n openshift-logging secret loki-bucket-odf -o jsonpath='{.data.AWS_ACCESS_KEY_ID}' | base64 -d)
SECRET_ACCESS_KEY=$(oc get -n openshift-logging secret loki-bucket-odf -o jsonpath='{.data.AWS_SECRET_ACCESS_KEY}' | base64 -d)

echo "---------------------------------------------------"
echo "BUCKET_HOST= $BUCKET_HOST"
echo ""
echo "BUCKET_NAME= $BUCKET_NAME"
echo ""
echo "BUCKET_PORT= $BUCKET_PORT"
echo ""
echo "ACCESS_KEY_ID= $ACCESS_KEY_ID"
echo ""
echo "SECRET_ACCESS_KEY= $SECRET_ACCESS_KEY"
echo ""
echo "---------------------------------------------------"
oc create -n openshift-logging secret generic logging-loki-odf --from-literal=access_key_id="$ACCESS_KEY_ID" --from-literal=access_key_secret="$SECRET_ACCESS_KEY" --from-literal=bucketnames="$BUCKET_NAME" --from-literal=endpoint="https://$BUCKET_HOST:$BUCKET_PORT"
