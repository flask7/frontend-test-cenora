FROM node:16.15.0

WORKDIR /usr/src/app

COPY package.json .
RUN yarn global add @quasar/cli
COPY . .
RUN yarn
EXPOSE 9000
CMD [ "quasar", "dev" ]
