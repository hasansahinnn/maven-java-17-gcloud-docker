FROM maven:3.8.4-openjdk-17

ENV DEBIAN_FRONTEND=noninteractive
ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

# ---- system deps + python3.9 ----
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates curl tar xz-utils gnupg; \
    \
    if apt-cache show python3.9 >/dev/null 2>&1; then \
      apt-get install -y --no-install-recommends python3.9 python3.9-distutils; \
      ln -sf /usr/bin/python3.9 /usr/local/bin/python3; \
    else \
      apt-get install -y --no-install-recommends python3 python3-distutils python3-pip; \
    fi; \
    \
    rm -rf /var/lib/apt/lists/*

ARG SDK_VERSION=404.0.0
RUN set -eux; \
    SDK_FILENAME="google-cloud-sdk-${SDK_VERSION}-linux-x86_64.tar.gz"; \
    curl -L -o /tmp/${SDK_FILENAME} "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${SDK_FILENAME}"; \
    mkdir -p /opt; \
    tar -zxf /tmp/${SDK_FILENAME} -C /opt; \
    /opt/google-cloud-sdk/install.sh --quiet; \
    rm -f /tmp/${SDK_FILENAME}

ENV PATH="/opt/google-cloud-sdk/bin:${PATH}"

# ---- components ----
RUN set -eux; \
    gcloud --version; \
    gcloud components install app-engine-java --quiet; \
    gcloud components list --only-local-state | head -n 200

WORKDIR /workspace
