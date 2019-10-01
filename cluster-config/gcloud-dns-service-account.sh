#!/usr/bin/env bash
set -euox pipefail

create_service_account() {
    local -r account_name=certbot-dns
    local -r gcloud_project="${1}"
    local -r service_account="${account_name}@${gcloud_project}.iam.gserviceaccount.com"

    if ! gcloud iam service-accounts describe "${service_account}" > /dev/null 2>&1; then
      gcloud iam service-accounts create "${account_name}"
    fi
    if [[ ! -f ${account_name}.key.json ]]; then
      gcloud iam service-accounts keys create \
        --iam-account="${service_account}" \
        ${account_name}.key.json
    fi
    gcloud projects add-iam-policy-binding "${gcloud_project}" \
      --member="serviceAccount:${service_account}" \
      --role="roles/dns.admin"
}
[[ -z "${1:-}" ]] && printf "Please provide Google Cloud project ID"

create_service_account $1