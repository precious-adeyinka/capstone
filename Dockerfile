FROM node:12.13.1-stretch-slim

WORKDIR /chitchat

COPY app/chitchat/ /chitchat/

RUN npm install -g npm && \
    npm install && \
    npm update && \
    npm run build

CMD ["/bin/bash", "-c", "npm run serve"]