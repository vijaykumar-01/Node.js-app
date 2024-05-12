# Stage 1: Build
FROM node:14 AS build
WORKDIR /app
COPY src/package.json src/package-lock.json ./
RUN npm install
COPY src/ .
# Stage 2: optimized image
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app .
EXPOSE 3000
CMD ["node", "index.js"]

