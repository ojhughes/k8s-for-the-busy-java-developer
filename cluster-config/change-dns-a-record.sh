#!/usr/bin/env bash
set -euox pipefail

change_dns_record() {
    local -r domain="${1}"
    local -r ip="${2}"
    local -r zone="${3}"

    gcloud dns record-sets import --zone="${zone}" --delete-all-existing /dev/null
    gcloud dns record-sets transaction start --zone="${zone}"
    gcloud dns record-sets transaction add --zone="${zone}" --name="${domain}" --ttl 3600 --type A "${ip}"
    gcloud dns record-sets transaction execute --zone="${zone}"
}
[[ -z "${1:-}" ]] && printf "Please provide domain name\n"
[[ -z "${2:-}" ]] && printf "Please IP address to update record with\n"
[[ -z "${2:-}" ]] && printf "Please name of Google Cloud DNS zone\n"

change_dns_record "${1}" "${2}" "${3}"