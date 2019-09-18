FROM node:9.4.0-alpine

WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . .

EXPOSE 8080
