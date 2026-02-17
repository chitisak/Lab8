FROM jenkins/jenkins:lts

USER root

# ===== System tools =====
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-pip \
    chromium \
    chromium-driver \
    wget \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# ===== Python virtual environment =====
RUN python3 -m venv /opt/robot-env

# ===== Install Robot + Selenium =====
RUN /opt/robot-env/bin/pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    selenium

# ===== Environment =====
ENV PATH="/opt/robot-env/bin:$PATH"
ENV CHROME_BIN=/usr/bin/chromium
ENV WEBDRIVER_CHROME_DRIVER=/usr/bin/chromedriver

RUN chown -R jenkins:jenkins /var/jenkins_home

USER jenkins