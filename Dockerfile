FROM phusion/baseimage:master-amd64

RUN apt-get update && apt-get install -y python-pip python-dev build-essential

RUN pip install --upgrade pip

#install aws cli
RUN pip install awscli --upgrade --user

#install azurecli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

#install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl" && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

#install kops
RUN curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.20.0/kops-linux-amd64 && chmod +x ./kops-linux-amd64 && mv ./kops-linux-amd64 /usr/local/bin/kops

RUN echo 'export PATH="$PATH:/root/.local/bin"' >> /root/.bashrc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
