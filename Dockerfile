# Use official LTS Node.js runtime
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Configure environment variables
ENV NPM_CONFIG_LEGACY_PEER_DEPS=true
ENV NODE_ENV=production
ENV PORT=3000

# Copy package definitions and npm configuration
COPY package*.json .npmrc* ./

# Install dependencies (with legacy peer deps handling for vite/esbuild compatibility)
RUN npm install --legacy-peer-deps

# Copy application source code
COPY . .

# Build Vite frontend and server bundle into dist/
RUN npm run build

# Expose application port (default 3000, dynamically overridden by blitz.cloud/cloud hosts)
ENV HOST=0.0.0.0
EXPOSE 3000

# Start production server
CMD ["node", "dist/server.cjs"]
