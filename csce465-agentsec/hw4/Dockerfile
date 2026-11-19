
FROM python:3.12.16-slim-trixie

# Install only the packages required by the lab.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        socat \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Create the application and C2 data directories.
RUN mkdir -p /app/web /data

# Copy lab files into the image.
WORKDIR /app

COPY c2.py /app/c2.py
COPY mock_skill.sh /app/mock_skill.sh
COPY fake_secrets.txt /app/fake_secrets.txt
COPY web/ /app/web/

# Make the mock skill executable.
RUN chmod +x /app/mock_skill.sh
