# Adopted from https://www.fl0.com/blog/the-perfect-multi-stage-dockerfile-for-node-js-apps

FROM node:21-alpine3.18 AS development

WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files over
# Do this FIRST to prevent copy of the huge node_modules folder from local machine
# The node_modules can contain machine-specific libraries, so it should be created 
# by the machine that's actually running the code
COPY package*.json ./

# The install includes dev dependencies
RUN npm install

# Copy the rest of source code into the image
COPY ./src ./src

# Run our start:dev command, which uses nodemon to watch for changes
CMD [ "npm", "run", "start:dev" ]

# "Builder" stage extends from the "development" stage but does an NPM clean install with only production dependencies 
FROM development as builder
WORKDIR /usr/src/app
RUN rm -rf node_modules
RUN npm ci --only=production
EXPOSE 80
CMD [ "npm", "start" ]
 
# Final stage uses a small image and copy the built assets across from the "builder" stage
FROM alpine:3.18 as production
RUN apk --no-cache add nodejs ca-certificates
WORKDIR /root/
COPY --from=builder /usr/src/app ./
CMD [ "node", "src/hello.js" ]
