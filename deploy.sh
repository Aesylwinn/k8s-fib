# Build images
docker build -t kylecooley/fib-client:latest -t kylecooley/fib-client:$SHA -f ./client/Dockerfile ./client
docker build -t kylecooley/fib-server:latest -t kylecooley/fib-server:$SHA -f ./server/Dockerfile ./server
docker build -t kylecooley/fib-worker:latest -t kylecooley/fib-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kylecooley/fib-client:latest
docker push kylecooley/fib-server:latest
docker push kylecooley/fib-worker:latest

docker push kylecooley/fib-client:$SHA
docker push kylecooley/fib-server:$SHA
docker push kylecooley/fib-worker:$SHA

# Deploy to k8s cluster
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kylecooley/fib-client:$SHA
kubectl set image deployments/server-deployment api=kylecooley/fib-server:$SHA
kubectl set image deployments/worker-deployment worker=kylecooley/fib-worker:$SHA
