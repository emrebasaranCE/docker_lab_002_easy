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