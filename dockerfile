FROM maven:3.8.4-openjdk-17

ENV DEBIAN_FRONTEND=noninteractive
ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      ca-certificates curl gnupg2 lsb-release python3 python3-pip && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
      | gpg --dearmor -o /etc/apt/keyrings/cloud.google.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
      > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
      google-cloud-cli \
      google-cloud-cli-app-engine-java && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/lib/google-cloud-sdk/bin:${PATH}"

RUN gcloud --version && python3 --version && mvn -v

WORKDIR /workspace
