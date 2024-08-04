 #!/bin/bash

 #####################################################
# About: This script will create a repo in bitbucket...
# Inputs Required:
#       1. USERNAME="username" & PASSWORD="password/PAT"
#       2. PROJECT_KEY="project key in which repo should created"
#       3. FILE_NAME="README.md"
#       4. BRANCH_NAME="which branch to be created"
#       5. BITBUCKET_API="https://bitbucket.com/rest/api/1.0/projects"
# Owner: Mohd Imran Mohd Yousuf
#
#####################################################

 USERNAME="username"
 PASSWORD="password/PAT"   #Also you can use API Token in place of password.
 PROJECT_KEY="SAMP"			 #This is the project key in which you need to create a repository.
 FILE_NAME="README.md"		 #Sample file.
 BRANCH_NAME="UAT"			 #You can change the name of the branch as per requirement.	

 BITBUCKET_API="https://bitbucket.com/rest/api/1.0/projects"

 CREATE_REPO_RESPONSE=$(curl -X POST -u $USERNAME:$PASSWORD "$BITBUCKET_API/$PROJECT_KEY/repos" -H "Content-Type: application/json" -d '{ "name": "test", "scmID": "git", "forkable": true, "is-private": true, "project": { "key": "$PROJECT_KEY" } }')

 REPO_NAME=$(echo $CREATE_REPO_RESPONSE | jq -r '.name')
 echo "$REPO_NAME Repo Created Successfully"

 REPO_URL=$(echo $CREATE_REPO_RESPONSE | jq -r '.links.clone[0].href')
 echo "$REPO_NAME Repo URL $REPO_URL"

 git clone $REPO_URL
 echo "$REPO_NAME cloned successfully"

 cd $REPO_NAME
 echo "Now you are in $REPO_NAME"

 git branch $BRANCH_NAME
 echo "$BRANCH_NAME Created sucessfully"
 
 echo "Hello Bitbucket" > $FILE_NAME
 echo "$FILE_NAME file created successfully"

 git add $FILE_NAME
 git commit -m "Initial commit"
 echo "$FILE_NAME committed"

 git push origin master
 echo "$FILE_NAME pushed to central repository"
