Instruction on deploy Elasticsearch (certified)

1) Create new nodes with specific taints
Example:
/home/workingdirocp/machine/os4-q7gmf-es.yaml

2) Deploy the Elasticsearch operator
oc apply -k operator/overlays/airgapped/

3) Deploy the elasticsearch instance
oc create -f elasticsearch-instance.yaml

4) Deploy the kibana instance
oc create -f kibana-instance.yaml

5) Create the kibana route
oc create -f kibana-route.yaml

6) to get elastic user password
oc get secret elasticsearch-instance-elastic-user -o go-template='{{.data.elastic | base64decode}}'

7) get status
oc get es,kb,pods -n elastic


