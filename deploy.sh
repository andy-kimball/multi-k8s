docker build -t andy537/multi-client:latest -t andy537/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andy537/multi-server:latest -t andy537/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andy537/multi-worker:latest -t andy537/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andy537/multi-client:latest
docker push andy537/multi-server:latest
docker push andy537/multi-worker:latest

docker push andy537/multi-client:$SHA
docker push andy537/multi-server:$SHA
docker push andy537/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andy537/multi-server:$SHA
kubectl set image deployments/client-deployment client=andy537/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andy537/multi-worker:$SHA
