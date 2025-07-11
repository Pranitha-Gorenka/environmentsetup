#prometheus,grafana using helm

#INSTALL HEML:
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

#INSTALL K8S METRICS SERVER:
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
 
#Verify that the metrics-server deployment is running the desired number of pods 
kubectl get pods -n kube-system
kubectl get deployment metrics-server -n kube-system

#INSTALL PROMETHEUS:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

#UPDATE HELM CHART REPOS:
helm repo update
helm repo list

#CREATE PROMETHEUS NAMESPACE:
kubectl create namespace prometheus
kubectl get ns

#INSTALL PROMETHEUS:
helm install prometheus prometheus-community/prometheus --namespace prometheus --set 
alertmanager.persistentVolume.storageClass="gp2" --set server.persistentVolume.storageClass="gp2"
kubectl get pods -n prometheus
kubectl get all -n prometheus

#CREATE GRAFANA NAMESPACE:
kubectl create namespace grafana

#INSTALL GRAFANA:
 elm install grafana grafana/grafana --namespace grafana --set persistence.storageClassName="gp2" --set 
persistence.enabled=true --set adminPassword='EKS!sAWSome' --set  service.type=LoadBalancer
kubectl get pods -n grafana
kubectl get service -n grafana
