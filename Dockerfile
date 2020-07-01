#build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG VUE_APP_OPENWEATHER_API_KEY
ENV VUE_APP_OPENWEATHER_API_KEY=${VUE_APP_OPENWEATHER_API_KEY}
RUN npm run build


#production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80

CMD ["nginx","-g","daemon off;"]