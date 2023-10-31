# syntax=docker/dockerfile:1
FROM node:18-alpine

#will result in success at CI Scan
#FROM node:18-alpine
#WORKDIR /app
#COPY . .
#RUN yarn install --production
#CMD ["node", "src/index.js"]
#EXPOSE 3000

#will result in failure at CI Scan
#ROM ubuntu:22.04 