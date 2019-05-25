# basic docker setup
A simple docker setup by using Docker Composer with 3 saparate container: PHP, MYSQL and APACHE

1. Create the `infra` directory at your root directory

2. Clone the repo `https://github.com/phucwan91/docker` into the `infra` directory

3. Create a `Makefile` file at you root directory then copy the folowing lines to the `Makefile` file

```
INFRA_DIR = infra

include $(INFRA_DIR)/docker/Makefile
```
4. Run `make init` only one time


