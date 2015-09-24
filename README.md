# selenium-test-dockerized [![Build Status](https://travis-ci.org/elgalu/selenium-test-dockerized.svg?branch=master)](https://travis-ci.org/elgalu/selenium-test-dockerized)
This docker image builds some basics tests by cloning [elgalu/selenium-test][] inside the container.

## Usage
It needs a selenium server, for example [docker-selenium][]

    docker run -d --name=myselenium elgalu/selenium:latest
    docker exec myselenium wait_all_done 30s

### Run the tests

    docker run --rm -ti --name=mytest --link myselenium:sel elgalu/selenium-test
    #=> Will connect to selenium at http://172.17.0.53:24444/wd/hub
    #=> Opening page http://www.google.com/adwords .....

#### Clean-up

    docker stop myselenium; docker rm myselenium

### Alternative: run the tests via shared network interface
So instead of `--link myselenium:sel` you can also force 2 containers to share the same virtual network interface through `--net=container:myselenium` in this case which will result in charing all TCP ports on the same *localhost*.

    docker run --rm -ti --name=mytest --net=container:myselenium elgalu/selenium-test
    #=> Will connect to selenium at http://localhost:24444/wd/hub
    #=> Opening page http://www.google.com/adwords .....

## Development
We don't use tag versions as this is a tiny project so it always defaults to *latest*

    docker build -t="elgalu/selenium-test" .
    docker push elgalu/selenium-test ;echo $?;beep

### Versioning
Each pushed docker image relates to a specific commit at [elgalu/selenium-test][]

* selenium-test commit: `99c2b9f6e45c9293803c29e21a55d7554d7f7bc5`
  docker-digest:`sha256:82baaf2ccc84ef8c638df6e13249497604b738f4984bdb53344ab31501a5693c`


[elgalu/selenium-test]: https://github.com/elgalu/selenium-test
[docker-selenium]: https://github.com/elgalu/docker-selenium
