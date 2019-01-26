docker build -t scaredcat/multi-client:latest -t scaredcat/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t scaredcat/multi-server:latest -t scaredcat/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t scaredcat/multi-worker:latest -t scaredcat/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push scaredcat/multi-client:latest
docker push scaredcat/multi-server:latest
docker push scaredcat/multi-worker:latest

docker push scaredcat/multi-client:$SHA
docker push scaredcat/multi-server:$SHA
docker push scaredcat/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=scaredcat/multi-server:$SHA
kubectl set image deployments/client-deployment client=scaredcat/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=scaredcat/multi-worker:$SHA
