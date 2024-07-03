# Use the latest Python Alpine image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app


RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy application files
COPY rit_directory rit_directory

#install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r rit_directory/requirements.txt

CMD flask --app rit_directory/app.py run --host=0.0.0.0 --debug
