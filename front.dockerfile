FROM node:21-alpine3.18 as builder
WORKDIR /app
RUN npm install
FROM nginx:alpine
COPY ./FrontEnd-Recetario/dist/ /usr/share/nginx/html/recetas