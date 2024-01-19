FROM node:18-alpine as build

WORKDIR /app

COPY package*.json ./

RUN yarn

COPY . .

RUN yarn build

FROM nginx:stable-alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]