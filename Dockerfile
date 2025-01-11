# Base image
FROM python:3.9-alpine3.13

# Maintainer information
LABEL maintainer="piyushgope77@gmail.com"

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PATH="/py/bin:$PATH"

# Copy application files
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

# Set working directory
WORKDIR /app

# Expose the application port
EXPOSE 8000

# Argument for development mode
ARG DEV=false

# Install dependencies
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt; fi && \
    rm -rf /tmp && \
    adduser --disabled-password --no-create-home dhanjo-user

# Use non-root user
USER dhanjo-user
