# Step 1:
# This is your Docker ID/path
$dockerpath="scgerkin/prediction-app"

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run prediction --image=$dockerpath

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward prediction 8000:80
