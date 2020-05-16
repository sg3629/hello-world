FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    apt-get install -y curl


# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade cython
RUN pip3 install ddtrace
COPY . /app

ENTRYPOINT [ "ddtrace-run" ]

EXPOSE 5050 8126
CMD ["python3", "./app.py"]
