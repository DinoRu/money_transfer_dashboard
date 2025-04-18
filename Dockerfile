#Stage 1
FROM node:22-slim AS build

WORKDIR /app

COPY package*.json .

RUN npm install -g npm@latest

RUN npm install

COPY . .

RUN npm run build

# Stage 2
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]