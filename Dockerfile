FROM node:20-slim

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libglib2.0-0 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxtst6 \
    libxrender1 \
    libfontconfig1 \
    libharfbuzz0b \
    libpangocairo-1.0-0 \
    xdg-utils \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install --unsafe-perm=true

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
