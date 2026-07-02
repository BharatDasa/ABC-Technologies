#!/bin/bash

###############################################################################
# ABC-Technologies
#
# Rollback Script
#
# Purpose:
# Roll back the application to the previous successful deployment.
#
###############################################################################

set -e

echo "========================================================="
echo " ABC-Technologies Rollback Started"
echo "========================================================="

echo ""
echo "Rolling back application..."
ansible-playbook ansible/playbooks/rollback.yml

echo ""
echo "========================================================="
echo " Current Deployment"
echo "========================================================="

kubectl get deployment -n abc-technologies

echo ""

kubectl rollout history deployment/abc-technologies \
  -n abc-technologies

echo ""

kubectl get pods -n abc-technologies -o wide

echo ""
echo "========================================================="
echo " Rollback Completed Successfully"
echo "========================================================="