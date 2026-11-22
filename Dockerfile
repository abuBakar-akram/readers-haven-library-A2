
# ==========================================
# STAGE 1: BUILDER
# ==========================================

# Use a pinned Node.js Alpine image for building
FROM node:22-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package configuration files first
# This improves Docker layer caching
COPY package*.json ./

# Install exact dependencies from package-lock.json
RUN npm ci

# Copy the HTML source files
COPY src/ ./src/

# Copy the shared CSS stylesheet
COPY styles/ ./styles/

# Build all HTML pages into the dist directory
RUN npm run build


# ==========================================
# STAGE 2: RUNTIME
# ==========================================

# Use a lightweight pinned Nginx image
FROM nginx:1.27-alpine

# Copy only the generated website from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Keep Nginx running in the foreground
CMD ["nginx", "-g", "daemon off;"]
