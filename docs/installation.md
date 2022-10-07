![artisan](../img/artisan.png){ align=right width=100 }

# Installation

Artisan is a command line interface (CLI) consisting of a single binary file.

Although the binary can be built for different Operating Systems and Processor Architectures, 
it is currently provided for [x86-64](https://en.wikipedia.org/wiki/X86-64){ target=_blank } based devices 
running on [Linux](https://en.wikipedia.org/wiki/Linux){ target=_blank }.

To install Artisan, both __debian__ and __rpm__ repositories are available
from SouthWinds Tech [here](https://packages.artisan.gdn){ target=_blank }.

An automated shell script is provided to facilitate the installation on any flavour of Linux [here](https://packages.artisan.gdn/install/get.sh){target=_blank}.

## Community Edition

On the server where you want to install Artisan:

```bash
# community edition (free)
$ curl -fsSL https://packages.artisan.gdn/install/get.sh | bash -s artisan_community
```

## Enterprise Edition

On the server where you want to install Artisan:

```bash
# enterprise edition (requires license)
$ curl -fsSL https://packages.artisan.gdn/install/get.sh | bash -s artisan_enterprise
```

### Artisan  User and Group

The enterprise installer creates a new System User called `artisan` with `UID=555` in a system group of the same name with `GID=555`.

!!! warning
    _To install artisan enterprise, the target Operating System must not have a pre-existing user with UID=555, otherwise the installer will fail._

The `artisan` user has a home under `/opt/artisan/` where the local registry files will be located.

!!! important "permissions to run"
    In order to run artisan enterprise you must either be logged as the `artisan` user (recommended for procudtion scenarios), or be a member of the `artisan` group.

#### Logging in as the artisan user (production)

```bash
# to switch to the artisan user
$ sudo su - artisan
```

#### Adding your user to the artisan group (development)

```bash
# to add your user to the artisan group
$ usermod -aG artisan your_username
```

### Creating users and tokens

Before the cli can be properly used, it needs to be activated: an identity token has to be requested by a registered user
and installed locally.

Once the token is set, Artisan Enterprise enables its full command list.

In order to activate Artisan Enterprise, follow the steps in the [Users Section](users.md) of this documentation.
