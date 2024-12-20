FROM apache/airflow:2.10.4-python3.10 as baseairflow

ARG DEBIAN_FRONTEND=noninteractive

ENV PYTHONUNBUFFERED=1

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libpq-dev \
    git \
    ca-certificates \
    curl \
    gnupg

# install nodejs following https://github.com/nodesource/distributions
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
ENV NODE_MAJOR=18
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update
RUN command apt-get install nodejs -y

USER airflow

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt