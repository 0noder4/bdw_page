FROM node:14-alpine

# Install nginx
RUN apk add --no-cache nginx

WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm ci

# Copy the rest of the application
COPY . .

# Install sass globally
RUN npm install -g sass

# Compile Sass for production
RUN npm run sass:prod

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx and watch for Sass changes
CMD sh -c "nginx && npm run sass:dev"