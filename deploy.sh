docker build -t zpalin/multi-client:latest -t zpalin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zpalin/multi-server:latest -t zpalin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zpalin/multi-worker:latest -t zpalin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zpalin/multi-client:latest
docker push zpalin/multi-server:latest
docker push zpalin/multi-worker:latest

docker push zpalin/multi-client:$SHA
docker push zpalin/multi-server:$SHA
docker push zpalin/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=zpalin/multi-server:$SHA
kubectl set image deployments/client-deployment client=zpalin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zpalin/multi-worker:$SHA
