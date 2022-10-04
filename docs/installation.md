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

### Creating users and tokens

Before the cli can be properly used, it needs to be activated: an identity token has to be requested by a registered user
and installed locally. 

Once the token is set, Artisan Enterprise enables its full command list.

In order to activate Artisan Enterprise, follow the steps in the [Users Section](users.md)
of this documentation.
