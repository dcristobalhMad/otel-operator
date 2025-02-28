all: create_cluster install_demo


create_cluster:
	kind create cluster --config cluster/config.yaml
	helm repo update
	sleep 120

remove_cluster:
	kind delete cluster --name test-cluster

install_demo:
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
	sleep 60
	kubectl create namespace observability
	kubectl apply -f  https://github.com/jaegertracing/jaeger-operator/releases/download/v1.42.0/jaeger-operator.yaml -n observability
	sleep 60
	kubectl apply -f jaeger/
	kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
	sleep 60
	kubectl apply -f otel/
	sleep 20
	kubectl apply -f app/