![artisan](../img/artisan.png){ align=right width=100 }

## Network service

The Artisan installer also installs a network service called __artnet__.
This service is responsible for listening for commands issued by other CLIs that have joined
an Artisan network. If you need distributed CLI capabilities then the service must be started.

!!! important "Please Note"
    The network service can only be started if Artisan has been activated (i.e. has a valid id token).

In order to enable the network service do the following:

```bash
# start the network service
$ sudo systemctl start artnet

# check status
$ sudo systemctl status artnet

# check logs for the "artnet" unit
$ sudo journalctl -u artnet
```

### Network Service Configuration

The network service consists of a [UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol) listener on port `40312`.

!!! important
    If you intend to use network functions, the device must have port `UDP/40312` open.

To improve the resilisency and efficiency of the connections, the server uses [QUIC](https://en.wikipedia.org/wiki/QUIC), a transport layer network protocol, also used in [HTTP/3](https://en.wikipedia.org/wiki/HTTP/3).

The server implements [TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) to encrypt the traffic between artisan clients and the server.

#### Launching server on specific IP address

It is possible to launch the server on a specific IP (as opposed to listening on all network interfaces) by passing the `--ip` flag to the following command located in the `arnet.service` systemd file:

```bash
$ art net serve --ip 127.0.0.1
```

#### Launching server in verbose mode

In order to request verbose output from the server, launch it with the `--debug` flag, as follows:

```bash
$ art net serve --debug
```
