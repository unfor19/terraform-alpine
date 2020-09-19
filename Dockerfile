FROM alpine:3.12

ARG TERRAFORM_VERSION
ARG AWSCLI_VERSION

RUN apk --update add bash curl git openssh-client py3-pip python3 jq
SHELL ["/bin/bash", "-c"]
WORKDIR $HOME/
COPY . .
RUN ./packages.sh

CMD ["/bin/bash"]
