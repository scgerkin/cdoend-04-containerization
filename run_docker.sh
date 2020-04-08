imageTag="prediction_image"
containerName="prediction_container"
hostPort="8000"
appPort="80"

# Remove existing container if exists
docker rm $containerName

# Build image
docker build --tag=$imageTag --rm .

# List images
docker images

# Run app
echo "Starting container with ID:"
docker run -d -p $hostPort:$appPort --name $containerName $imageTag
echo "Attaching to container."
docker attach $containerName
