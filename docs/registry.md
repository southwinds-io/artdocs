![artisan](../img/artisan.png){ align=right width=100 }

# Registry

Artisan can publish and consume packages to and from Artisan registries. You can think of an Artisan registry as
a remote store for packages so that it is easy for some users to publish packages that can be downloaded by other users.

SouthWinds Tech provides a [basic registry](https://quay.io/repository/artisan/artr-basic?tab=info) that you can use to 
understand how it works and why not, to start publishing your own packages.

## Getting started

To try the registry in a machine running docker and artisan do the following:

```bash
# spin up a docker container with the registry
docker run -d --name artr \
    -p 8082:8080 \
    -e ARTR_ADMIN_USER=admin -e ARTR_ADMIN_PWD=adm1n \
    -e ARTR_READ_USER=reader -e ARTR_READ_PWD=r3ad3r \
    quay.io/artisan/artr-basic

# build a test package
# create some dummy content for the package
mkdir my-package
cd my-package
touch hello_world.txt
cd ..

# package the content
art build -t localhost:8082/test/my-package:1.0 --target my-package

# push the package to the registry
art push -u admin:adm1n localhost:8082/test/my-package:1.0

# check if package has been pushed to registry
art ls -r localhost:8082 -u admin:adm1n

# remove the package from the local machine
art rm localhost:8082/test/my-package:1.0

# check the package has been deleted
art ls

# pull the package from the registry
art pull -u admin:adm1n localhost:8082/test/my-package:1.0

# check the package has been pulled
art ls
```
