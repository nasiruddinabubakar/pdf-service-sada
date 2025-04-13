FROM node:20-slim

# Install Chromium dependencies
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
    xdg-utils \
    libdrm2 \
    libxshmfence1 \
    libgbm1 \
    libxcb-dri3-0 \
    libxss1 \
    libgtk-3-0 \
    libu2f-udev \
    libpci3 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libxfixes3 \
    libxrender1 \
    libxext6 \
    --no-install-recommends \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy app files
COPY package*.json ./
RUN npm install

COPY . .

# Expose app port
EXPOSE 3000

CMD ["node", "index.js"]
