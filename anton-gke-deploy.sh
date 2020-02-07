# Build our images, log each one, push each to docker hub
docker build -t antondeswardt/docker-complex-client:latest -t antondeswardt/docker-complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t antondeswardt/docker-complex-server:latest -t antondeswardt/docker-complex-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t antondeswardt/docker-complex-worker:latest -t antondeswardt/docker-complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push antondeswardt/docker-complex-client:latest
docker push antondeswardt/docker-complex-client:$GIT_SHA
docker push antondeswardt/docker-complex-server:latest
docker push antondeswardt/docker-complex-server:$GIT_SHA
docker push antondeswardt/docker-complex-worker:latest
docker push antondeswardt/docker-complex-worker:$GIT_SHA

# Apply all configs to the "k8s" folder, kubectl should be there (GKE)
kubectl apply -f k8s

# Imperatively set latest images on each deployment
kubectl set image deployments/client-deployment client=antondeswardt/docker-complex-client:$GIT_SHA
kubectl set image deployments/server-deployment server=antondeswardt/docker-complex-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=antondeswardt/docker-complex-worker:$GIT_SHA
