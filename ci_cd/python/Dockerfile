FROM python:3.11-slim

RUN mkdir -p /home/github && addgroup github && useradd -d /home/github -g github github && chown github:github /home/github

RUN apt-get update && apt-get install -y curl

USER github

WORKDIR /home/github

RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH=/home/github/.local/bin:$PATH

RUN poetry config virtualenvs.in-project true