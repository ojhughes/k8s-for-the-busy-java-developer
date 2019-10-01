#!/usr/bin/env bash
set -euo pipefail

create_service_account() {
    local -r account_name=certbot-dns
    local -r gcloud_project="${1}"
    local -r service_account="${account_name}@${gcloud_project}.iam.gserviceaccount.com"

    #gcloud iam service-accounts create "${account_name}"
    #gcloud iam service-accounts keys create \
    #  --iam-account="${service_account}" \
    #  ${account_name}.key.json

    gcloud projects add-iam-policy-binding "${gcloud_project}" \
      --member="serviceAccount:${service_account}" \
      --role="roles/dns.admin"
}
[[ -z "${1:-}" ]] && printf "Please provide Google Cloud project ID"

create_service_account $1