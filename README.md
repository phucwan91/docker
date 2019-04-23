# basic docker setup
A simple docker setup by using Docker Composer with 3 saparate container: PHP, MYSQL and APACHE

1. Create folder `infra` at your root directory

2. Clone the repo `https://github.com/phucwan91/docker` 

3. Copy these lines to your root `Makefile`
```
INFRA_DIR = infra

include $(INFRA_DIR)/docker/Makefile
```
4. Run `make init`


