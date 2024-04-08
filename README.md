# Node.js Hello App with Express

This is a very simple Hell World application written in Node.js. The application is built into a container image. The purpose of this repo is to demonstrate a GitHub action that will build the application into the container image and run it to verify the application is working from the container.

See the `verify.yml` action script file.

When changes are pushed to GitHub the script will run.

## Running the application locally

Build the container image.

```sh
docker image build -t my-restful-service .
```

Run the container:

```sh
docker container run -p 8123:8123 my-restful-service
```

Test the [service](http://localhost:8123):

```sh
`curl http://localhost:8123`
```