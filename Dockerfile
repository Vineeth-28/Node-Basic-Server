# Use official Node.js image
FROM node:20-alpine

# Create app directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining files
COPY . .

# Expose app port
EXPOSE 3000

# Start application
CMD ["npm", "start"]