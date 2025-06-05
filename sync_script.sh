#!/bin/bash

echo "DigitalOcean Spaces Sync Script"
echo "Action: $1"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo


if [ "$#" -ne 1 ] || { [ "$1" != "upload" ] && [ "$1" != "download" ]; }; then
    echo "Usage: $0 [upload|download]"
    exit 1
fi


read -p "Enter the DigitalOcean bucket name (e.g., easm-docker-images): " bucket_name
read -p "Enter the local folder to sync (e.g., ./docker_images): " local_dir
read -p "Enter the region endpoint (e.g., blr1.digitaloceanspaces.com): " region_endpoint

if [ ! -d "$local_dir" ]; then
    echo "Error: Directory '$local_dir' does not exist."
    exit 1
fi

bucket_url="s3://$bucket_name"
endpoint_url="https://$region_endpoint"
log_file="do_sync_$(hostname)_$(date +%F_%T).log"
tmp_file=$(mktemp)


trap "rm -f $tmp_file" EXIT

log() {
    echo "$1" | tee -a "$tmp_file"
}

send_log_report() {
    echo -e "\nSync Log Summary:"
    cat "$tmp_file"
    rm -f "$tmp_file"
}

if [ "$1" == "upload" ]; then
    log "Uploading contents of '$local_dir' to DigitalOcean Space '$bucket_name'..."
    aws s3 sync "$local_dir" "$bucket_url" --endpoint-url "$endpoint_url" >> "$tmp_file" 2>&1
elif [ "$1" == "download" ]; then
    log "Downloading contents from DigitalOcean Space '$bucket_name' to '$local_dir'..."
    mkdir -p "$local_dir"
    aws s3 sync "$bucket_url" "$local_dir" --endpoint-url "$endpoint_url" >> "$tmp_file" 2>&1
fi


if [ $? -eq 0 ]; then
    log "Operation successful."
else
    log "Error: Operation failed. See log for details."
fi

send_log_report
