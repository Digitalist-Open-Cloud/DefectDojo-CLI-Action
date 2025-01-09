FROM python:3
ARG VERSION="0.1.11"

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir defectdojo-cli2==${VERSION}
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]