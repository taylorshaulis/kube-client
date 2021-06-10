FROM phusion/baseimage:master-amd64

#apt stuff
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
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 -o get-helm-3 && \
    chmod +x get-helm-3 && \
    ./get-helm-3 -v 3.2.0 --no-sudo

#install kubectx
RUN curl https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubectx_v0.9.3_linux_arm64.tar.gz -o kubectx.tar.gz && \
    tar -xvf kubectx.tar.gz && \
    mv kubectx /usr/local/bin/kubectx && \
    rm kubectx.tar.gz LICENSE

#install kubens
RUN curl https://github.com/ahmetb/kubectx/releases/download/v0.9.3/kubens_v0.9.3_linux_arm64.tar.gz  -o kubens.tar.gz && \
    tar -xvf kubens.tar.gz && \
    mv kubens /usr/local/bin/kubens && \
    rm kubens.tar.gz LICENSE

#install terraform
RUN curl https://releases.hashicorp.com/terraform/0.13.4/terraform_0.13.4_linux_amd64.zip -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    rm terraform.zip

RUN echo 'export PATH="$PATH:/root/.local/bin"' >> /root/.bashrc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
