#!/bin/bash

#####################################################
# About: This script will show the list of all projects in Bitbucket...
# Inputs Required:
#       1. username="USERNAME" & password="PAT"
#       2. base_url="https://bitbucket.com"
# Owner: Mohd Imran Mohd Yousuf
#
#####################################################
username="USERNAME"
password="PAT"

base_url="https://https://bitbucket.com"

project_url="$base_url/rest/api/1.0/projects"

echo "$project_url"

page_size=25
start=0


project_response=$(curl -t "$username:$password" "$project_url"?start=$start)
echo "$project_response"

if [[ $project_response == *"errormessages"* ]]; then
    echo "Failed"
    exit
fi
echo "$project_response"

project_keys=`echo "$project_response" | jq -r '.values[].key')`
echo "$project_keys"

        #for project_key in "$project_keys[@]"; do
        #       echo "####Print Project Key####"
        #        echo "Project: $project_key"
        #done

        #if [[ ${#project_keys[@]} -lt $page_size ]]; then
        #       break
        #fi

        #start=$((start + page_size))
#curl -u "$username:$password" "$project_url"
done
