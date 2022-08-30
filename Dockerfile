FROM apache/airflow:2.3.2

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    build-essential

USER airflow

COPY requirements.txt .
RUN pip install -r requirements.txt