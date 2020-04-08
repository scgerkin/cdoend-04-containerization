[![scgerkin](https://circleci.com/gh/scgerkin/cdoend-04-containerization.svg?style=shield)](https://circleci.com/gh/scgerkin/cdoend-04-containerization)


# Project Overview
This project demonstrates creating a virtual environment for a Python application that can be run inside a Docker container and subsequently inside a Kubernetes cluster.

## Application Overview
The Python application is a pre-trained `sklearn` model that can be used to predict housing prices in Boston. A sample script to use the application is [included as `make_prediction.sh`](./make_prediction.sh).

```shell
$ ./make_prediction.sh
```

## Run the application locally
A `Makefile` is included that will set up a virtual environment with all the dependencies necessary for the project.
To setup the `venv`:
```shell
$ make setup
```
This will create a virtual environment in `~/.devops` and source it to activate it. You can deactivate by running the command:
```shell
$ deactivate
```
All that is left is to install the dependencies and start the application:
```shell
$ make install
$ python app.py
```

## Run the application in a Docker container
The [included `run_docker.sh` script](./run_docker.sh) is all that is needed to get a Docker container running with the application. It will create an image (if one does not exist already) and start a container.
```shell
$ ./run_docker.sh
```
It will start the container and attach the current terminal to it to be able to see the log output. In a separate terminal, run the `make_prediction` script to see a prediction and the log output.
```shell
$ ./make_prediction.sh
```

### Running the application in a Kubernetes cluster
The Docker image is hosted on the Docker Hub repository and can be retrieved by running the following command:
```shell
$ docker pull scgerkin/prediction-app
```
To start a Kubernetes cluster of the application, run the following command and use the [included `run_kubernetes.sh` script](./run_kubernetes.sh):
```shell
$ minikube start
$ ./run_kubernetes.sh
```
The script will attempt to start port-forwarding automatically; however, the pod takes time to load. After the pod has loaded, you can run the script again to start port-forwarding and interact with the application as above (in another terminal, run `make_prediction.sh`).

After you are finished testing the cluster, use `CTRL+C` to send a `SIGINT` to the port forwarding, stop the `minikube` and (optionally) delete the resources.
```shell
$ minikube stop
$ minikube delete
```
