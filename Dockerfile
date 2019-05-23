FROM python:3.7-alpine
MAINTAINER Matt Maclaine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# creates empty folder on docker image, switches to it as default directory
RUN mkdir /app
WORKDIR /app
# copies directory into docker image
COPY ./app /app

# create a user for running applications (-D) and switch to them, for security
RUN adduser -D user
USER user
