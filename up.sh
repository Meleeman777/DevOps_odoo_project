#!/bin/bash
cd .infra/terraform && terraform apply -auto-approve
curl -X POST "http://meleeman:$JENKINSTOKEN@localhost:8080/job/odoo-project/build"
