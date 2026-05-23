FROM n8nio/n8n:2.20.9 AS n8n

FROM alpine:3.23 AS task-runner-py-download
RUN apk add --no-cache git && \
    git clone --depth 1 --branch n8n@2.20.9 https://github.com/n8n-io/n8n.git /tmp/n8n-repo && \
    mv /tmp/n8n-repo/packages/@n8n/task-runner-python /task-runner-python && \
    rm -rf /tmp/n8n-repo

FROM python:3.14-alpine
RUN apk add --no-cache nodejs npm && \
    addgroup -S node -g 1000 && \
    adduser -S node -u 1000 -G node -h /home/node
COPY --from=n8n /usr/local/lib/node_modules/n8n /usr/local/lib/node_modules/n8n
COPY --from=task-runner-py-download /task-runner-python /usr/local/lib/node_modules/@n8n/task-runner-python
RUN ln -s /usr/local/lib/node_modules/n8n/bin/n8n /usr/local/bin/n8n && \
    python3 -m venv /usr/local/lib/node_modules/@n8n/task-runner-python/.venv && \
    /usr/local/lib/node_modules/@n8n/task-runner-python/.venv/bin/pip install --no-cache-dir /usr/local/lib/node_modules/@n8n/task-runner-python && \
    chown -R node:node /home/node && \
    chown -R node:node /usr/local/lib/node_modules/@n8n/task-runner-python
ENV N8N_PYTHON=python3
EXPOSE 5678
USER node
CMD ["n8n", "start"]
