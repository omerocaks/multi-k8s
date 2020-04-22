docker build -t levanderia/multi-client:latest -t levanderia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t levanderia/multi-server:latest -t levanderia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t levanderia/multi-worker:latest -t levanderia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push levanderia/multi-client:latest
docker push levanderia/multi-server:latest
docker push levanderia/multi-worker:latest

docker push levanderia/multi-client:$SHA
docker push levanderia/multi-server:$SHA
docker push levanderia/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=levanderia/multi-server:$SHA
kubectl set image deployments/client-deployment client=levanderia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=levanderia/multi-worker:$SHA