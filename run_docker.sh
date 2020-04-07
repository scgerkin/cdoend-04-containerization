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
echo -e "${GREEN}Building a fresh image...${NC}"
docker build --tag=$ctag --rm .

# Step 2:
# List docker images
echo -e "${GREEN}Listing recent images...${NC}"
docker image ls

# Step 3:
# Run flask app
echo -e "${GREEN}Starting container...${NC}"
docker run -p $outPort:$inPort -d --name $cname $ctag

# get the truncated container ID
cid=$(docker ps -qf "name=$cname")

echo -e "
${GREEN}The ${BLUE}$cname${GREEN} container has started in detached mode.
${RED}Image Tag: ${BLUE}$ctag
${RED}Container Name: ${BLUE}$cname
${RED}Container ID: ${BLUE}$cid
${RED}Application port: ${BLUE}$outPort${NC}

${GREEN}You can now post predictions to the service.
${GREEN}Run ${BLUE}make_prediction.sh ${GREEN}for a sample output.

The container will now be attached to STDIN.
${RED}Stop the container with ${BLUE}CTRL+C${NC}
"

docker attach $cname

echo -e "
${RED}Container Stopped!
Doing some clean up..."

removedContainer=$(docker container rm $cname)

echo -e "${GREEN}The container '${BLUE}$removedContainer${GREEN}' has been ${RED}removed.
${GREEN}Restart the container by running ${BLUE}run_docker.sh${GREEN} again.
${NC}"
