FROM debian:stable-slim

RUN apt update && apt-get upgrade
RUN apt install ca-certificates apt-transport-https gnupg wget -y
RUN wget -O - https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list
RUN apt update
RUN apt install -y java-21-amazon-corretto-jdk libxi6 libxtst6 libxrender1 python3 python3-pip
RUN pip install requests --break-system-packages

WORKDIR /velocity

COPY getvelocity.py getvelocity.py
COPY start.sh start.sh

WORKDIR /usr/src/app

CMD ["bash", "/velocity/start.sh"]
