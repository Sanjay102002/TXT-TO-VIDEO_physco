FROM python:3.10.8-slim-buster

# Update the sources.list to use archive repositories
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt
RUN pip install pytube
ENV COOKIES_FILE_PATH="youtube_cookies.txt"
CMD gunicorn app:app & python3 main.py
#spidy
