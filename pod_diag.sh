#!/bin/bash
#4 August 2022 Taeho Choi
#Check pod status which is not Running due to PV issue
#

kubectl get namespace -o custom-columns=NAMESPACE:.metadata.name --no-headers | while read namespace
do
         kubectl get pods -n $namespace --field-selector=status.phase!=Running --no-headers  --selector='!job-name'  -o custom-columns=pod_name:.metadata.name |  while read pod_name
        do
            echo "Checking this pod $pod_name in this ns $namespace" ; kubectl describe pod $pod_name -n $namespace | egrep 'already attached to node|RUN fsck MANUALLY|watch channel had been closed|failed to attach to node'
        done
done
