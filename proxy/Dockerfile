FROM mhart/alpine-node:14.6.0
WORKDIR /opt/app
COPY package.json yarn.lock ./

RUN yarn install
COPY . ./

ARG PORT
ENV PORT 3000
CMD yarn run start
EXPOSE $PORT
