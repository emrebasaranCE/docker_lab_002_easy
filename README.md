"# docker_lab_002_easy" 

For this example, after getting the app files we created a Dockerfile and wrote some commands to it:

- Since our app uses nodejs, we are creating our image based on node image
    - `FROM node`

- Giving the information where the commands are running
    - `WORKDIR /app`

- First dot/path: where to copy from (Host file system)
- Second path: where to copy to (image/container file system)
    - `COPY . /app`

- Installing the dependencies 
    - `RUN npm install`

- Exposing the port 3000 for the network to access
    - `EXPOSE 80`

- This approach is wrong because we want the images ready to run, not run on the build.
    - `# RUN node server.js`

- CMD is the command that will be executed when the container is started
    - `CMD ["node", "server.js"]`


And now to build this image, we simply write:
`docker build .`
- Few things to be carefull about:
    - Docker should be working in the backside while trying to build the image.
    - While using the cli, since we use `.` for the path, current directory of the cli should be where our dockerfile located.
    
To build this image in a better way, we can give name and a tag like this:
- `docker build -t myapp:v1.0 .`

To run this docker: `docker run -p 3000:80 -d [image_id]`

## IMPORTANT NOTE
### Why use `-p 3000:80` ?

When using the EXPOSE [port_number] in Dockerfile, it is the best practice but not enough actully. Turns out even though we let the image run on a specified port, we still need to let the docker know which port we will be communicating with the container via`-p [host_port_id]:[image/container_port_id]`

## Actions after changes made to our app.
After any changes done to our app, we have to build the image from the scratch. To make this step faster, we can change some line in order to use docker's layered approach:

`WORKDIR /app` Cached     
`COPY . /app` Re-run   
`RUN npm install` Re-run

When we build our dockerfile after a small change to server.js, this process uses cached data for `WORKDIR /app`. But for `COPY . /app` and `RUN npm install` docker tends to create new layers (re-runs). To improve speed, we can make some changes like this:

`WORKDIR /app`
`COPY package.json /app`  
`RUN npm install`  
`COPY . /app`  

## How this is better?
Its based on the idea that docker uses layered approach when creating images. Therefor as long as we dont change any package in package.json, `RUN npm install` will be the same. Now this is works like this:

`WORKDIR /app` Cached  
`COPY package.json /app` Cached*  
`RUN npm install` Cached*  
`COPY . /app` Re-run 

*since we didnt change any packages, both `COPY package.json /app` and `RUN npm install` not effected.

  
