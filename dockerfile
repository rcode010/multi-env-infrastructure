FROM node:25-alpine3.22

WORKDIR /app

COPY ./package.json /app/
COPY ./package-lock.json /app/

COPY src /app/src

RUN npm ci --omit=dev

EXPOSE 3000

CMD [ "node","src/app.js" ]