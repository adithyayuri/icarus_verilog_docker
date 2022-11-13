# Docker image for Icarus verilog

**Docker**:

Docker image for Icarus verilog, the Dockerfile is built on top of Ubuntu base image. 

**Github Actions**:

GitHub actions is set to trigger of the *commit TAG*. 

It then follows the steps as configured:

- Pulls the commit with the tag
- Builds tags docker image with the same verison tag number
- Login to *Docker cli*
- Push images to *Dockerhub*

**Dockerhub**: [link](https://hub.docker.com/repository/docker/adithyayuri/icarus_verilog)
