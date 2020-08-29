FROM mhart/alpine-node:14.6.0
WORKDIR /opt/app
COPY package.json yarn.lock ./

RUN yarn install
COPY . ./

CMD yarn run start
EXPOSE 3000
