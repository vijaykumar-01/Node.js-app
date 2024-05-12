# Stage 1: Build
FROM node:14 AS build
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy package.json and package-lock.json
COPY src/package.json src/package-lock.json ./
 
# Install dependencies
RUN npm install
 
# Copy the rest of the application code
COPY src/ .
 
# Stage 2: Production-ready image
FROM node:14-alpine
 
# Set the working directory inside the container
WORKDIR /app
 
# Copy the built application from the 'build' stage
COPY --from=build /app .
 
# Expose the port your app runs on
EXPOSE 3000
 
# Command to run the application
CMD ["node", "index.js"]

