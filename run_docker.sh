#!/usr/bin/env bash

# container name and image tag
cname="prediction"
ctag="prediction_app"

# container port mappings
inPort=80
outPort=8000

# for distictive output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[1;31m'
NC='\033[0m'

# Step 1:
# Build image and add a descriptive tag
docker build --tag=$ctag --rm .

# Step 2:
# List docker images
echo -e "${GREEN}Listing recent images...${NC}"
docker image ls

# Step 3:
# Run flask app
docker run -p $outPort:$inPort -d --name $cname $ctag

# get the truncated container ID
cid=$(docker ps -qf "name=$cname")

echo -e "
${GREEN}Running container in detached state...
${RED}Image Tag: ${BLUE}$ctag
${RED}Container Name: ${BLUE}$cname
${RED}Container ID: ${BLUE}$cid
${GREEN}Access the application on port: ${BLUE}$outPort${NC}
"
