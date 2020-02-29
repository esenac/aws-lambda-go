FROM hashicorp/terraform

LABEL maintainer="esenac"

WORKDIR /srv

ADD providers.tf .

RUN terraform init
