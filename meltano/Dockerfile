ARG MELTANO_IMAGE=meltano/meltano:v2.13-python3.10

FROM $MELTANO_IMAGE

ARG MELTANO_DATABASE_URI
ARG MELTANO_ENV

WORKDIR /project

# Install any additional requirements
COPY ./requirements.txt .
RUN pip install -r requirements.txt

RUN apt update && apt install openssh-server postgresql libpq-dev sudo -y

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

RUN touch .env

ENTRYPOINT service ssh restart && tail -f /dev/null