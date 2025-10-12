# ----------------------------
# 1️⃣ Build stage
# ----------------------------
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy all files and build
COPY . .
RUN npm run build


# ----------------------------
# 2️⃣ Serve stage (Nginx)
# ----------------------------
FROM nginx:alpine

# Clean default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy build result from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html
# If using Create React App, change to /app/build

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
