ARG MELTANO_IMAGE=meltano/meltano:v3.2.0-python3.10

FROM $MELTANO_IMAGE

ARG MELTANO_DATABASE_URI
ARG MELTANO_ENV

WORKDIR /project

RUN apt update && apt install openssh-server postgresql libpq-dev sudo -y

# Install any additional requirements
COPY ./requirements.txt .
RUN pip install -r requirements.txt


RUN echo 'root:ubuntu' | chpasswd

RUN mkdir -p /run/sshd

# generate server keys
RUN ssh-keygen -A

# allow root to login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

RUN echo $MELTANO_ENV
RUN echo "source /venv/bin/activate" >> ~/.bashrc
RUN echo "export MELTANO_ENVIRONMENT=$MELTANO_ENV" >> ~/.bashrc
RUN echo "export MELTANO_DATABASE_URI=$MELTANO_DATABASE_URI" >> ~/.bashrc
RUN echo "export NO_COLOR=1" >> ~/.bashrc

RUN touch .env

ENTRYPOINT service ssh restart && tail -f /dev/null