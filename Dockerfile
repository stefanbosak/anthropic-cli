# Non-hardened alternative
#FROM debian:stable-slim

# Hardened
FROM dhi.io/debian-base:trixie-debian13-dev

# Build arguments
ARG TARGETARCH
ARG TARGETOS

ARG CONTAINER_USER=user
ARG CONTAINER_GROUP=user

ARG CONTAINER_USER_ID=1000
ARG CONTAINER_GROUP_ID=1000

ARG WORKSPACE_ROOT_DIR="/home/${CONTAINER_USER}"

# Anthropic CLI (ant) release to install.
# Kept in sync by the version-passing workflows; see .github/workflows/*-multiplatform-pipeline.yaml
ARG ANT_CLI_VERSION=1.21.0

WORKDIR "${WORKSPACE_ROOT_DIR}"

# OCI Standard Labels
# https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.description="Anthropic ant CLI container and tooling"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    bash-completion \
    bubblewrap \
    bc \
    ca-certificates \
    curl \
    dnsutils \
    git \
    gzip \
    iproute2 \
    iputils-ping \
    jq \
    kmod \
    lsof \
    openssh-client \
    pandoc \
    pigz \
    procps \
    psmisc \
    ripgrep \
    rsync \
    socat \
    unzip \
    wget \
    whois \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

RUN if getent group "${CONTAINER_GROUP_ID}" > /dev/null; then \
      _existing_group="$(getent group "${CONTAINER_GROUP_ID}" | cut -d: -f1)"; \
      if [ "${_existing_group}" != "${CONTAINER_GROUP}" ]; then \
        groupmod -n "${CONTAINER_GROUP}" "${_existing_group}"; \
      fi; \
    else \
      groupadd --gid "${CONTAINER_GROUP_ID}" "${CONTAINER_GROUP}"; \
    fi \
    && if getent passwd "${CONTAINER_USER_ID}" > /dev/null; then \
         _existing_user="$(getent passwd "${CONTAINER_USER_ID}" | cut -d: -f1)"; \
         if [ "${_existing_user}" != "${CONTAINER_USER}" ]; then \
           if [ -d "/home/${_existing_user}" ]; then \
             mv "/home/${_existing_user}" "/home/${CONTAINER_USER}"; \
           fi; \
           usermod -d "/home/${CONTAINER_USER}" -l "${CONTAINER_USER}" "${_existing_user}"; \
         fi; \
       else \
         useradd \
           --uid "${CONTAINER_USER_ID}" \
           --gid "${CONTAINER_GROUP_ID}" \
           --groups "${CONTAINER_GROUP}" \
           -M -d "${WORKSPACE_ROOT_DIR}" \
           -s /bin/bash \
           "${CONTAINER_USER}"; \
       fi \
    && mkdir -p /workspace /usr/local/bin \
    && chown -R "${CONTAINER_USER}:${CONTAINER_GROUP}" "${WORKSPACE_ROOT_DIR}" /workspace \
  # Install ant (Anthropic CLI)
  && TARGETOS_=$(echo "${TARGETOS}" | tr '[:upper:]' '[:lower:]') \
  && curl -fsSL "https://github.com/anthropics/anthropic-cli/releases/download/v${ANT_CLI_VERSION}/ant_${ANT_CLI_VERSION}_${TARGETOS_}_${TARGETARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin ant \
  && chmod +x /usr/local/bin/ant \
  && ant @completion bash > /etc/bash_completion.d/ant

# Switch to non-root user
USER "${CONTAINER_USER}"

RUN cp /etc/skel/.bashrc "${WORKSPACE_ROOT_DIR}" \
    && echo 'export PATH=${HOME}/.local/bin:${PATH}' >> "${WORKSPACE_ROOT_DIR}/.bashrc"

CMD ["ant"]
