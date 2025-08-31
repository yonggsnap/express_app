FROM node:16 AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

# FINAL IMAGE
FROM node:16-alpine

WORKDIR /usr/src/app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /usr/src/app .

# Change ownership of the files to our created user
RUN chown -R appuser:appgroup .

USER appuser

EXPOSE 8080

CMD ["node", "index.js"]