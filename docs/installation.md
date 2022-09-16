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

### Enabling the network service 

The installer also installs a network service called __artnet__.
This service is responsible for listening for commands issued by other CLIs that have joined
an Artisan network. If you need distributed CLI capabilities then the service must be started:

```bash
# start the network service
$ sudo systemctl start artnet

# check status
$ sudo systemctl status artnet

# check logs for the "artnet" unit
$ sudo journalctl -u artnet
```

!!! note 
    _In contrast to Artisan Community edition, Artisan Enterprise needs a license to run. 
    If you want to activate Artisan Enterprise, read the [Users Section](users.md)
    of this documentation._
   