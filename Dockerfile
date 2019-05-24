FROM python:3.7-alpine
MAINTAINER Matt Maclaine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# creates empty folder on docker image, switches to it as default directory
RUN mkdir /app
WORKDIR /app
# copies directory into docker image
COPY ./app /app

# create a user for running applications (-D) and switch to them, for security
RUN adduser -D user
USER user
