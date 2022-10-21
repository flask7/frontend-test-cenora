# Cenora Test (cenora)

In both cases, you must to use deepstream, and it can be used dowloading the server from:

https://deepstream.io/

And activating it with:

./deepstream start

You must to try it with Docker by run:

docker run -p 6020:6020 deepstreamio/deepstream.io

For Docker:

- Run (make sure that your Docker engine is up):
  - docker build -t cenora-test .
  - docker run -it -p 9000:9000 --rm cenora-test

For NPM:

- Run:
  - npm i
  - quasar dev

# frontend-test-cenora
