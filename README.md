`adzerk/boot-clj-and-redis` is a public Docker image built on top of the [official Redis Docker image](https://registry.hub.docker.com/_/redis) that installs and sets up Oracle Java 8 and the latest version of Boot.

> **Note**: The Java/Boot part of the Dockerfile is copied verbatim from the Dockerfile for the [adzerk/boot-clj](https://github.com/adzerk-oss/boot-clj-docker-image) Docker image. If that Dockerfile is ever updated, this one should probably be updated too. As of right now, Docker does not provide a way to "mix in" / "include" instructions from another Dockerfile, so this is a work-around.

This repo is set up as an [automated build](https://docs.docker.com/docker-hub/builds) on Docker Hub. The `adzerk/boot-clj-and-redis` Docker image is automatically built from the Dockerfile in this repo and deployed to Docker Hub.

To use as a base image for another Dockerfile, put this at the top of the Dockerfile:

    FROM adzerk/boot-clj-and-redis:2.8.19
