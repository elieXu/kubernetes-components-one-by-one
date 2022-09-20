# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

PATH=$PATH:/home/opc/k8s/etcd/etcd-v3.4.20-linux-amd64:/home/opc/k8s

startKubelet() {
  cd /home/opc/k8s

  nohup ./kubelet --config=/home/opc/k8s/configs/kubeletConfigFile.yaml --container-runtime=remote --container-runtime-endpoint=unix:///run/cri-dockerd.sock --kubeconfig=/home/opc/k8s/configs/kubelet.kubeconfig &> nohup_kubelet.out &
}

startEtcd() {
  nohup etcd --data-dir /home/opc/k8s/etcd/etcd-v3.4.20-linux-amd64/data.etcd &> nohup_etcd.out &
}

startAPIServer() {
  cd /home/opc/k8s

  #nohup ./kube-apiserver --etcd-servers=http://127.0.0.1:2379 --service-cluster-ip-range=10.0.0.0/16 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-signing-key-file=/home/opc/k8s/certs/service-account-key.pem --service-account-key-file=/home/opc/k8s/certs/service-account-pub.pem --token-auth-file=/home/opc/k8s/token_auth_file --disable-admission-plugins=ServiceAccount &> nohup_apiserver.out &

  nohup ./kube-apiserver --etcd-servers=http://127.0.0.1:2379 --service-cluster-ip-range=10.0.0.0/16 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-signing-key-file=/home/opc/k8s/certs/service-account-key.pem --service-account-key-file=/home/opc/k8s/certs/service-account-pub.pem --token-auth-file=/home/opc/k8s/token_auth_file &> nohup_apiserver.out &
}

startScheduler() {
  cd /home/opc/k8s

  nohup ./kube-scheduler --kubeconfig=/home/opc/k8s/configs/kubelet.kubeconfig &>nohup_scheduler.out &
}

startKubeController() {
  cd /home/opc/k8s

  nohup ./kube-controller-manager --kubeconfig=/home/opc/k8s/configs/kubelet.kubeconfig &>nohup_kubeController.out &
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
