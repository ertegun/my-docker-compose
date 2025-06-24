FROM python:alpine3.20

WORKDIR /app
COPY waiter.py .

# Gerekli build araçları ve bağımlılıklar
RUN apk add --no-cache \
  gcc \
  musl-dev \
  libffi-dev \
  openssl-dev \
  python3-dev \
  cargo \
  build-base \
  && pip install --no-cache-dir \
  pymysql \
  pymongo \
  pika \
  cryptography \
  && apk del gcc musl-dev libffi-dev openssl-dev python3-dev cargo build-base

CMD ["python", "waiter.py"]
