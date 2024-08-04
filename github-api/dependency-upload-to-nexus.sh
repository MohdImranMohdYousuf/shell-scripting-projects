#!/bin/bash

#####################################################
# About: This script will upload maven dependency from local server to nexus repository...
# Inputs Required:
#       1. REPO_URL="nexus-repo-url"
#       2. USERNAME="username" & PASSWORD="password/PAT"
# Owner: Akash Chaudhary & Pranshul Minhas
#
#####################################################

# Set Nexus repository URL
REPO_URL="nexus-repo-url"
# Nexus repository credentials
USERNAME="username"
PASSWORD="password/PAT"
# Function to deploy files recursively while maintaining directory structure
deploy_files() {
   local dir=$1
   local parent_dir=$2
   for file in "$dir"/*; do
       if [ -d "$file" ]; then
           # If directory, recursively call deploy_files with updated coordinates
           local subdirectory=$(basename "$file")
           deploy_files "$file" "$parent_dir$subdirectory/"
       else
           # If file, construct the Nexus repository path and check if it exists
           local file_name=$(basename "$file")
           local relative_path=${parent_dir#${HOME}/.m2/repository/}
           local nexus_dir="${relative_path}${file_name}"
           response=$(curl -u "$USERNAME:$PASSWORD" -X HEAD -s -w "%{http_code}" "$REPO_URL$nexus_dir" -o /dev/null)
           if [ "$response" != "200" ]; then
               # File does not exist, upload it
               response=$(curl -u "$USERNAME:$PASSWORD" -X PUT "$REPO_URL$nexus_dir" -T "$file" -s -w "%{http_code}" -o /dev/null)
               if [ "$response" != "201" ]; then
                   echo "Error: Failed to upload $file_name. HTTP response code: $response"
               fi
           else
               echo "Skipping existing file: $nexus_dir"
           fi
       fi
   done
}
# Start deploying files from the .m2 directory
deploy_files "$HOME/.m2/repository" ""
