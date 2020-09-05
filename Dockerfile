FROM 

# workdir
WORKDIR /app

# source code
COPY . /app/chitchat /app

# install dependencies
RUN npm install -g npm s&& \
    npm install
    
# expose service port
EXPOSE 80

# run shell command
CMD ["npm","run serve"]

# FROM alpine
# RUN apk add --no-cache ca-certificates && update-ca-certificates
# ADD https://get.aquasec.com/microscanner .
# RUN chmod +x microscanner
# RUN ./microscanner NGNmNTE1MWJjNjAw