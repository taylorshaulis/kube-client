FROM phusion/baseimage:master-amd64

RUN apt-get update && apt-get install -y python3-pip python3-dev build-essential

RUN pip3 install --upgrade pip

#install aws cli
RUN pip3 install awscli --upgrade --user

#install azurecli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl" && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

#install helm
#https://helm.sh/docs/intro/install/
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

#install kops
RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.20.0/kops-linux-amd64 && chmod +x ./kops && mv ./kops /usr/local/bin/kops

RUN echo 'export PATH="$PATH:/root/.local/bin"' >> /root/.bashrc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
