FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    gnupg \
    lsb-release \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - --yes

# Install poetry-plugin-export
RUN /root/.local/bin/poetry self add poetry-plugin-export

ENV PATH="/root/.local/bin:$PATH"
ENV PYTHONUNBUFFERED=1