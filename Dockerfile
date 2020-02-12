FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install \
  ca-certificates \
  curl \
  jq \
  openssh-client \
  wget \
  unzip \
  --no-install-recommends -y

#  Install Terraform
RUN TERRAFORM=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r .current_version) \
  && wget --no-verbose --tries=5 --timeout=5 \
  "https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip" -O /tmp/terraform.zip && \
  unzip /tmp/terraform.zip -d /tmp && \
  mv /tmp/terraform /usr/local/bin/terraform && \
  chmod +x /usr/local/bin/terraform


#  Terraform Plugins (for environments that don't have internet access)
COPY provider.tf .
RUN terraform init


FROM ubuntu:bionic

RUN mkdir -p /root/.terraform.d/plugins
COPY --from=0 /usr/local/bin/terraform /usr/local/bin/
COPY --from=0 .terraform/plugins/ /root/.terraform.d/plugins/

WORKDIR /app

ENTRYPOINT [ "terraform" ]
