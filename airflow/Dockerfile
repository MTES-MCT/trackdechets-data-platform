FROM apache/airflow:2.5.1-python3.10

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libpq-dev \
    git
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - &&\
    apt-get install -y nodejs

USER airflow

COPY requirements.txt .
RUN pip install -r requirements.txt