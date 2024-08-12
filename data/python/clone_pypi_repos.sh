#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

get_github_url() {
    local package_name=$1
    local pypi_url="https://pypi.org/pypi/${package_name}/json"

    # Fetch package data from PyPI
    local package_data=$(curl -s "$pypi_url")

    # Check if the package exists
    if [[ "$package_data" == *"Not Found"* ]]; then
        echo "Package $package_name not found on PyPI"
        return 1
    fi

    # Trying to find GitHub URL in project_urls, home_page, or Source
    local github_url=$(echo "$package_data" | grep -oP '"(https://github.com/[^"]+)"' | head -1 | tr -d '"')

    # Cleaning up the URL if found. This was difficult. ;)
    if [ -n "$github_url" ]; then
        github_url=$(echo "$github_url" | sed -E 's#(https://github.com/[^/]+/[^/]+).*#\1#')
        echo "$github_url"
    else
        echo "No GitHub URL found for $package_name"
        return 1
    fi
}

clone_repo() {
    local repo_url=$1
    local package_name=$2

    if [ -n "$repo_url" ]; then
        if git clone "$repo_url" "$package_name"; then
            echo "Successfully cloned $package_name"
        else
            echo "Failed to clone $package_name"
        fi
    else
        echo "No GitHub URL available for $package_name"
    fi
}

main() {
    local input_file="${SCRIPT_DIR}/pypi_packages.txt"

    if [ ! -f "$input_file" ]; then
        echo "Error: $input_file not found"
        exit 1
    fi

    while IFS= read -r package || [ -n "$package" ]; do
        if [ -n "$package" ]; then
            echo "Processing $package..."
            github_url=$(get_github_url "$package")
            if [ $? -eq 0 ]; then
                clone_repo "$github_url" "$package"
            fi
            echo "------------------------"
        fi
    done <"$input_file"
}

main
