FROM 974360507615.dkr.ecr.eu-west-1.amazonaws.com/node:18-slim as builder

ARG NODE_ENV=production
ARG AWS_REGION
ARG CODEARTIFACT_AUTH_TOKEN

ENV NODE_ENV $NODE_ENV
ENV AWS_REGION=$AWS_REGION
ENV CODEARTIFACT_AUTH_TOKEN $CODEARTIFACT_AUTH_TOKEN

WORKDIR /install

COPY .npmrc package*.json tsconfig.json ./

RUN NODE_ENV=development npm ci --ommit=dev --ignore-scripts && npm cache clean --force --loglevel=error

COPY . .

RUN npm run build --if-present && \
    npm prune --production

# build final image
FROM 974360507615.dkr.ecr.eu-west-1.amazonaws.com/node:18-slim as final
ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV
ENV ASYNC_CONTEXT=true

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app

USER node

COPY --from=builder --chown=node:node /install ./

EXPOSE 3000
CMD ["node", "-r", "@letsdeel/init", "dist/src/server.js"]
