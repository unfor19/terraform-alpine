#!/bin/bash

## Functions
install_awscli(){
    if [[ -n $AWSCLI_VERSION ]]; then
        pip3 install --no-cache-dir awscli=="${AWSCLI_VERSION}"
    else
        # Install latest version
        pip3 install --no-cache-dir awscli
    fi
}


get_latest_terraform_version(){
    local org_name=$1
    local repo_name=$2
    curl -s https://api.github.com/repos/${org_name}/${repo_name}/releases/latest | grep "tag_name" | cut -d'v' -f2 | cut -d'"' -f1
}


install_terraform(){
    local terraform_version

    if [[ -n $TERRAFORM_VERSION ]]; then
        terraform_version=${TERRAFORM_VERSION//v/}
    else
        # Get latest version
        terraform_version=$(get_latest_terraform_version hashicorp terraform)
    fi

    if [[ -z $terraform_version ]]; then
        echo "[ERROR] terraform_version is empty"
        exit 1
    fi

    curl -sL "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip" -o terraform.zip
    unzip -qq terraform.zip && \
        rm terraform.zip && \
        mv terraform /usr/local/bin/terraform && \
        chmod +x /usr/local/bin/terraform
}


## Main
install_awscli
install_terraform