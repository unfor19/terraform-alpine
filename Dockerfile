FROM alpine:3.12

ARG TERRAFORM_VERSION=0.12.28
ARG AWSCLI_VERSION=1.18.2

RUN apk --update add bash curl git openssh-client py3-pip python3
RUN pip3 install --no-cache-dir awscli==${AWSCLI_VERSION}


WORKDIR $HOME/
RUN curl -sL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip
RUN unzip -qq terraform.zip && \
    rm terraform.zip && \
    mv terraform /usr/local/bin/terraform && \
    chmod +x /usr/local/bin/terraform

CMD ["/bin/bash"]
