# Since our app uses nodejs, we are creating our image based on node image
FROM node


# Giving the information where the commands are running
WORKDIR /app


# To make building faster, we are copying the package.json file first
COPY package.json /app
# Installing the dependencies 
RUN npm install


# First dot/path: where to copy from (Host file system)
# Second path: where to copy to (image/container file system)
COPY . /app


# Exposing the port 3000 for the network to access
EXPOSE 80


# RUN node server.js
# This approach is wrong because we want the images ready to run, not run on the build.


# CMD is the command that will be executed when the container is started
CMD ["node", "server.js"]
