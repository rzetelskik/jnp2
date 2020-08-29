FROM mhart/alpine-node:14.6.0
WORKDIR /opt/app
COPY package.json yarn.lock ./
RUN yarn install
COPY . ./

ARG PROXY_PORT
ENV PROXY_PORT 80
CMD yarn run start
EXPOSE $PROXY_PORT
