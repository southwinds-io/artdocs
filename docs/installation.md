![artisan](../img/artisan.png){ align=right width=100 }

# Installation

Artisan is a command line interface (CLI) consisting of a single binary file.

Although the binary can be built for different Operating Systems and Processor Architectures, 
it is currently provided for [x86-64](https://en.wikipedia.org/wiki/X86-64){ target=_blank } based devices 
running on [Linux](https://en.wikipedia.org/wiki/Linux){ target=_blank }.

To install Artisan, both __debian__ and __rpm__ repositories are available
from SouthWinds Tech [here](https://packages.artisan.gdn){ target=_blank }.

An automated shell script is provided to facilitate the installation on any flavour of Linux [here](https://packages.artisan.gdn/install/get.sh){target=_blank}.

## Installing the Community Edition

On the server where you want to install Artisan:

```bash
# community edition (free)
$ curl -fsSL https://packages.artisan.gdn/install/get.sh | bash -s artisan_community
```

## Installing the Enterprise Edition

On the server where you want to install Artisan:

```bash
# enterprise edition (requires license)
$ curl -fsSL https://packages.artisan.gdn/install/get.sh | bash -s artisan_enterprise
```

!!! note 
    In contrast to Artisan Community edition, Artisan Enterprise can be freely installed, 
    but it needs a license to run. If you want to activate Artisan Enterprise, read the [Users Section](users.md)
    of this documentation.
   