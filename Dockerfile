FROM alpine:3.6

WORKDIR /usr/src/midori
COPY package.json package-lock.json ./

RUN apk add --update \
    && apk add --no-cache --virtual .deps nodejs-current nodejs-npm curl \
    && apk add --no-cache --virtual .build-deps ca-certificates build-base g++ git \
    && apk add --no-cache --virtual .npm-deps libjpeg-turbo-dev cairo-dev \ 
        giflib-dev libpng-dev pango-dev

COPY . .

RUN npm install \
    && apk del .build-deps

RUN npm i sqlite3

CMD [ "node", "--harmony", "index.js"]
