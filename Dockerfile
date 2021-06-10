FROM phusion/baseimage:master-amd64

RUN apt-get update && apt-get install -y unzip

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.40.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

#install kubectl
RUN curl -LO "https://dl.k8s.io/release/v1.16.15/bin/linux/amd64/kubectl" && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

#install helm
#https://helm.sh/docs/intro/install/
#RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get-helm-3 && \
    ./get-helm-3 -v 3.2.0

#install kubectx
RUN curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_arm64.tar.gz && \
    tar -xvf kubectx_v0.9.3_linux_arm64.tar.gz && \
    mv kubectx /usr/local/bin/kubectx && \
    rm kubectx_v0.9.3_linux_arm64.tar.gz LICENSE

#install kubens
RUN curl -LO https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_arm64.tar.gz && \
    tar -xvf kubens_v0.9.3_linux_arm64.tar.gz && \
    mv kubens /usr/local/bin/kubens && \
    rm kubens_v0.9.3_linux_arm64.tar.gz LICENSE

#install terraform
RUN curl -LO https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip && \
    unzip terraform_0.13.4_linux_amd64.zip && \
    mv terraform /usr/local/bin/terraform

RUN echo 'export PATH="$PATH:/root/.local/bin"' >> /root/.bashrc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
