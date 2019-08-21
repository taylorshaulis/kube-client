FROM phusion/baseimage

RUN apt-get update && apt-get install -y python-pip python-dev build-essential

RUN pip install --upgrade pip

RUN pip install awscli --upgrade --user

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.10.13/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

RUN curl -LO https://github.com/kubernetes/kops/releases/download/1.10.1/kops-linux-amd64 && chmod +x ./kops-linux-amd64 && mv ./kops-linux-amd64 /usr/local/bin/kops

RUN echo 'export PATH="$PATH:/root/.local/bin"' >> /root/.bashrc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
