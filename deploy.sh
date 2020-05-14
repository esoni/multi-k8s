docker build -t dariofrongillo/multi-client:latest -t dariofrongillo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dariofrongillo/multi-server:latest -t dariofrongillo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dariofrongillo/multi-worker:latest -t dariofrongillo/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dariofrongillo/multi-client:$SHA
docker push dariofrongillo/multi-server:$SHA
docker push dariofrongillo/multi-worker:$SHA
docker push dariofrongillo/multi-client:latest
docker push dariofrongillo/multi-server:latest
docker push dariofrongillo/multi-worker:latest
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dariofrongillo/multi-server:$SHA
kubectl set image deployments/client-deployment client=dariofrongillo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dariofrongillo/multi-worker:$SHA