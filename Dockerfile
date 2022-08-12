FROM apache/airflow:2.3.2

RUN pip install pygsheets google-api-python-client google-auth-httplib2 google-auth-oauthlib