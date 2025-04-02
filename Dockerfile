FROM node:18 as builder

WORKDIR /usr/src/app

ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}

COPY package.json .

RUN npm install --force

COPY . .

RUN npm run build

# ----------------------------------------------------------------

FROM nginx:alpine
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]


# https://api.12.lebondeveloppeur.net/