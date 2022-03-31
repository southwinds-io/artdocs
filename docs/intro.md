![artisan](../img/artisan.png){ align=right width=100 }

# Artisan

**_Artisan_** is a [command line interface (CLI)](https://en.wikipedia.org/wiki/Command-line_interface) plus a set of complementing services 
written in [Go](https://golang.org/); aiming to automate and integrate the efforts of development and IT operations teams.

_You can think of **Artisan** as a toolbox that solves complex problems faced by organisations when building, packaging,
distributing and running software systems in modern platforms and heterogeneous networks._

It is the _**build and run system**_ for [Onix Configuration Manager](https://onix.gatblau.org) that standardise and secure the complete lifecycle of:

- Enterprise applications (e.g. micro-services on container platforms)
- Disparate scripts (e.g. shell, ansible, terraform, etc)
- Source code (e.g. java, javascript, golang, etc)
- Operating System configuration
- Application configuration and
- any other similar I.T. resources

## Use Cases

[ [go to the top](#artisan) ]

___
_Package any automation logic/tool so that it can be deployed and run anywhere, including far edge and air gaped networks._
___
_Build enterprise libraries of reusable and composable automation that use disparate tools._
___
_Build CI/CD pipelines on plain hosts or Kubernetes._
___
_Trigger automation processes from well-known events suchs as S3 bucket uploads._
___
_Transfer complex enterprise applications securely to air gaped networks._
___
_Create application deployment configurations for Docker and Kubernetes platforms._
___
_Build and release complex enterprise applications._
___
_Use different tool chains without installing them on a host._


## Why Artisan?

[ [go to the top](#artisan) ]

The current I.T. landscape is complex. Over the time, applications have transitioned from monoliths to services, to micro services.

To deal with the resulting increasingly complex configurations, new tools have emerged within the umbrella of _infrastructure as a code_. Additionally, _container platforms_ have also appeared, as a solution to deal with modern applications operational requirements.

Despite the power of these individual tools and platforms, organisations still need to deal with a plethora of technologies and configuration options.

In the context of [DevSecOps](https://en.wikipedia.org/wiki/DevOps#DevSecOps,_Shifting_Security_Left) practices, standardisation means that all development, security and operational teams can combine toolchains and execute them in the same consistent and secure way, regardless of the stage in the [application development lifecycle](https://en.wikipedia.org/wiki/Systems_development_life_cycle).

Although this is technologically possible, without a consistent set of standards and abstractions that guide the way logic and tools are packaged, distributed and consumed across a plethora of automation vendors, teams usually find themselves "reinventing the wheel" for every new project and have to manage more than one toolchain in different ways.

!!! important ""
      **_Artisan_** provides a standard approach to publish and consume automation (regardless of the tool selected), via **_Artisan_** packages and registries.

## How Artisan packages compare to container images?

[ [go to the top](#artisan) ]

**_Artisan_** packages are created in a similar way as container images. Once created, they can be tagged, pushed to and pulled from an **_Artisan_** registry.

However, **_Artisan_** packages are smaller than container images, and are designed to be deployed in a container at runtime, as well as to run as is in a host.

This allows for the creation of runtime libraries consisting of standard container images with specific toolchains.

Packages are the logic and containers are the environment where the logic runs.

!!! note
      By separating logic and containers at build time and combining them at runtime complex flows can be easily created to execute any combination of packaged functions interchanging pre-configured runtimes.

## Standard but flexible

[ [go to the top](#artisan) ]

Sometimes standardisation is associated with opinionated and inflexible. **_Artisan_** tries hard to be flexible by placing the control in the hands of the developers.

**_Artisan_** runs commands from a configuration file - i.e. the build file. This file allows developers to inject instructions at key parts of the process, telling **_Artisan_** what to do, and thus providing the freedom to customise the execution logic. **_Artisan_** then takes these instructions and execute them in a well defined, secure and standard process.

## Secure by default

[ [go to the top](#artisan) ]

Cryptography is hard, so **_Artisan_** puts the emphasis on making cryptographic operations seamless, easy to use and implicitly engrained in the fabric of packages.

!!! note
    Using [Pretty Good Privacy (PGP)](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) keys by default, **_Artisan_** can automatically validate that the package being executed comes from a trusted source and it is safe to run.

## Embedded SOPs

[ [go to the top](#artisan) ]

When companies onboard new employees or team members, they need to go through a learning curve before they can be effective at their jobs. Time is always in short supply for training.

Standard Operating Procedures (SOP) are documents that contain the necessary instructions to complete critical processes.

SOPs ensure that a business can keep running smoothly as employees come and go, thus providing business continuity.

!!! hint
      **_Artisan_** embeds SOPs in packages making them easy to distribute and readily available to operators.

## Core Subsystems

[ [go to the top](#artisan) ]

Artisan achieves all the above by combining the functions in the following core subsystems:

1. [packaging subsystem](#packaging-subsystem) packages and unpackages files using [zip](https://en.wikipedia.org/wiki/ZIP_(file_format)) archiving and compression format.

2. [run subsystem](#run-subsystem) defines and calls functions either within packages or on the file system.

3. [publishing subsystem](#publishing-subsystem) provides the means to tag, push, pull and open packages, enforcing the cryptographic verification of author/source and package integrity checks.

4. [input subsystem](#input-subsystem) to improve usability and foster reusability, automation packages must have a standard way to publish and consume variables and generate variable specifications. The input system provides options for automated generation of variable files and loading variables from different sources.

5. [crypto subsystem](#crypto-subsystem) provides the means to create, import, export, rotate and load [PGP](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) keys, encrypt and decrypt files, and sign and verify packages and check integrity of downloaded packages via package digests.

6. [app subsystem](#app-subsystem) provides the means to generate application deployment configurations and to package and release container based enterprise applications.

___

### Packaging subsystem

[ [go to the top](#artisan) ]

Automation typically comes as a set of disparate files that need to be executed in a particular order using specific toolchains.

This leads to difficulties in:

- _distributing the files in a way that hides the implementation details from the operator; and_

- _ensuring that tampering of the files, either wilfull or unconcious, has not happened before their execution_

#### Automation as components

[ [go to the top](#artisan) ]

The packaging subsystem achieves encapsulation by creating a [zip file](<https://en.wikipedia.org/wiki/ZIP_(file_format>) containing all the automation code along with a [manifest](https://en.wikipedia.org/wiki/Manifest_file).

The manifest declares the functions that can be executed on such package as well as the their signature, i.e. the inputs required by such function).

!!! hint
      This model simplifies the signing, distribution and execution of automation and reduces the storage and bandwidth requirements for their distribution.

#### Automation as applications

[ [go to the top](#artisan) ]

Automation should be treated as a software application and subjected to the same software development lifecycle. This lifecycle means testing and publishing the automation like an application; in a way that can be used by an operator as a [black box](https://en.wikipedia.org/wiki/Black_box).

#### Simple to run for an operator

[ [go to the top](#artisan) ]

Operators can be trained to execute the automation but do not necessarily understand how the automation code has been put together or what are the required automation toolchains.

Therefore, there is a need for [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)), a term coined in the object-oriented programming (OOP) community, that refers to restricting the direct access to some of internal logic that make up a function or component.

___

### Run subsystem

The run subsystem provides a structured framework to run automation scripts and code in general.

#### _**The build file**_

[ [go to the top](#artisan) ]

At the core of the run subsystem is the build file: a [YAML file](https://en.wikipedia.org/wiki/YAML) that defines:

- _**functions**_: lists of commands that have to be executed in sequence. For those familiar with GNU Make, _**Artisan**_ functions are similar to [make functions](https://www.gnu.org/software/make/manual/html_node/Functions.html).

- _**profiles**_: the operation(s) required to create _**Artisan**_ packages. In the simplest form they can be just the location of a target folder to zip, in a more complex case, they might involve execution of shell commands or other _**Artisan**_ functions required to prepare the contents of a package.

- _**inputs**_: define the information required by functions and profiles to work. Inputs can be ordinary variables, secrets, (PGP) keys or files.

Build files can be chained, that is, one can call one build file from another build file. This allow to break complex functions in a manageasble way.

_**Artisan**_ has two distinct ways to execute logic, and each of those ways can happen within a container or within a host.

#### _**In Place Execution**_

[ [go to the top](#artisan) ]

In place execution is when _**Artisan**_ executes functions or profiles in build files that have not been boxed in a package.

Source code sits in a location in the file system, typically, where the command line terminal prompt is. This is useful mostly for development purposes as execution can be done without creating a package.

!!! hint
    _**Artisan**_ uses _in place execution_ within a runtime that is part of a flow with a git source. If a flow uses a git source, the files have already being mounted in the runtime and pulling package within the runtime, is not required.

!!! note
     **In place execution** can be invoked using the `run` command.

#### _**Package Execution**_

[ [go to the top](#artisan) ]

Package execution is when _**Artisan**_ executes functions in a build file that is embedded in the package. This is the way logic is mostly executed in operation environments once a package is released.

!!! hint
      _**Artisan**_ uses _package execution_ within  runtimes, i.e. upon launching a runtime with a toolchain, _**Artisan**_ pulls the relevant package within the runtime and execute the requested function.

!!! note
     **Package execution** can be invoked using the `exe` command.

#### _**Using Runtimes**_

[ [go to the top](#artisan) ]

In addition to the two execution modes descussed before, _**Artisan**_ can perform in place or package execution within a linux container in a host with [docker](https://docs.docker.com/get-started/) or [podman](https://podman.io/) installed.

This is useful when the toolchain required to run the automation is not installed on the host.

For example, consider a package that requires [Ansible](https://www.ansible.com/) and you want to run it on a host. As Ansible command line does not work on Windows, _**Artisan**_ can lunch a Linux based Ansible runtime container and execute the logic within it.

!!! hint
     runtimes can be used with both in-place and package execution:

     - use the `runc` command instead of `run` to launch a runtime for in-place execution.
     - use `exec` command instead of `exe` to launch a runtime for package execution.

#### _**Runtimes**_

[ [go to the top](#artisan) ]

_**Artisan**_ runtimes are container images that implement a standard execution interface.

Upon creation a bootstrap script within the container calls the _**Artisan**_ _command line interface_ (also inside the container), which in turn, pulls the designated _**Artisan**_ package from a registry and execute the required function.

There are various different container runtimes such as the ones <a href="http://quay.io/artisan/" target="_blank">here</a> with different toolchains. 


!!! caution
    Runtimes must be created in such way that they implement the handshake required by _**Artisan**_.
    It is recommended that custom runtimes are based on [runtime based images](https://github.com/gatblau/artisan/tree/master/runtime/base). These base images ensure the runtime follows the interface required by _**Artisan**_ to run the package logic.

#### _**Flows**_

[ [go to the top](#artisan) ]

Flows are a way to run a sequence of functions from one or more packages that require the same or different runtimes.

A flow definition is a YAML file containing a series of steps, each of them  as follows:

```yaml
---
name: the-flow-name
description: a description of what the flow does

steps:
  # the definition for a step
  - name: one-step
    description: run a function in a package using a runtime
    package: the-name-of-the-package
    runtime: the-runtime-image-to-use
    function: the-function-in-the-package-to-call

  # other steps can be defined below
  - name: another-step
    ...
...
```

The _**Artisan**_ CLI can request the execution of a flow by sending the flow definition to an _**Artisan**_ Runner - see `flow run` command.

#### _**Runners**_

[ [go to the top](#artisan) ]

A runner is an HTTP service that is in charge of the execution a package function or a flow.

___

### Publishing subsystem

The publishing subsystem goal is to facilitate the distribution of packages and the dynamic installation of packages into hosts and runtimes.

The _**Artisan**_ CLI can create, tag and push packages to an _**Artisan**_ registry. Once there, packages can be pulled and published functions can be run.

At the heart of the publishing subsystem is the Artisan Registry.

#### _**The Artisan Registry**_

[ [go to the top](#artisan) ]

In a similar way to a [Docker registry](https://docs.docker.com/registry/), the _**Artisan**_ Registry is a stateless, highly scalable server side application that stores and lets you distribute _**Artisan**_ Packages.

The registry can sit in front of various backends, such as a [Nexus Repository](https://www.sonatype.com/nexus/repository-pro).

The registry is typically released as a container image which can run from any [Kubernetes](https://kubernetes.io/) implementation.

##### _**Discoverable Library**_

[ [go to the top](#artisan) ]

The _**Artisan**_ Registry can be used to implement an enterprise wide library made of digitally signed, black boxed and discoverable packages that can be ubiquitously run in hosts or container runtimes, fully encapsulating their implementaion details and underlying toolchains.

Packages in the library can be mixed and matched using flows, to cater for a wide range of complex Enterprise automation scenarios.

___

### Input subsystem

[ [go to the top](#artisan) ]

The input subsystem provides the means to pass configuration to packages using environment variables and mounting files.

In order to make functions and profiles configurable _**Artisan**_ can can read input information from a build file or the package manifest.

Four types of _inputs_ are available as follows:

1. `var`: variables define information required to run a function or profile.

2. `secret`: are like variables but their values are given a particular treatment to ensure they are protected.

3. `key`: allows to PGP keys easily load and pass PGP keys to packages and flows.

4. `file`: allows to load and pass arbitrary files to packages and flows.

!!! note
      _As any piece of input could be used by one or more functions or profiles, inputs have to be bound to them. Bindings allow Artisan to actively require the inputs before the execution of a function can take place._

___

### Crypto subsystem

[ [go to the top](#artisan) ]

_**Artisan**_ uses PGP encryption to digitally sign every package. A private key is used to sign packages.

In the same way, any package that is executed must pass the verification of its digital signature before they can do so. The counterpart public key is used to verify the package signature.

_**Artisan**_ can create PGP keys, and has a local registry where keys can be placed. The registry allows to place keys in a hierarchical structure to facilitate overriding following the package group/name convention.

For example placing a key in the root make it usable to sign/verify all packages, where as placing a key withing a specific group and or name make the key usable within that package group or name.

___

### App Subsystem

[ [go to the top](#artisan) ]

The app subsystem provides the means to facilitate:

1. _**Application Deployments**_: generate application deployment configuration files for different platforms from application and service manifests.
2. _**Application Releases**_: support the export, transfer and import of _**all**_ artefacts (packages and images) required for a modern application to work in a completely air gaped environment.

#### Application Deployments

[ [go to the top](#artisan) ]

##### App Manifests

Instead of defining a set of deployment configurations, _**Artisan**_ provides a set of semantics to define how an application is made up of services (using service manifests) along with service dependencies and connections. Then, a transpilation process can, by reading such information, generate deployment configurations for a specific platform (e.g. docker compose, kubernetes)

Typically, the deployment of an application can be defined in 3 types of files:

| file | description |
|---|---|
| spec.yaml | defines a list of images required for a particular release |
| myapp.yaml | defines the list of service profiles that can be deployed |
| mysvc.yaml | defines the configuration of a specific service that forms part of an application |

The block below shows a typical application manifest:

<details><summary><b>./art-reg.yaml</b></summary>
<p>

```yaml
---
name: Artisan Registry
description: Services required to enact an Artisan Registry
version: 1.0
# possible different configurations of services that could be deployed
profiles:
  - name: full
    description: Deploys all services for a registry
    services:
      - name: nexus-app
      - name: artreg-app
        # customise any behaviours of the service
        is:
          # defines the service as publicly accessible
          public: artreg.overriden.com

  - name: nexus
    description: Deploys only the registry backend
    services:
      - name: nexus-app

# a list of services used in profiles
services:
  - name: nexus-app
    description: Nexus 3 repository manager service
    # the location of the service manifest, can also be an http(s) URI
    uri: ./svc/nexus-app.yaml
    # the unique name of the image to use in the service as defined in the sspec.yaml file
    image: IMAGE_NEXUS3
    # multiple ports defined as name - value pairs
    port:
      http: "8081"
      docker-http: "5000"
      docker-https: "5001"
    # service behaviours
    is:
      public: nexus.mydomain.com

  - name: artreg-app
    description: Artisan Registry
    uri: ./svc/artreg-app.yaml
    image: IMAGE_ARTISAN_REGISTRY
    # single port defined as a value
    port: "8082"
    is:
      public: artreg.mydomain.com
      encrypted-in-transit:
...
```

</p>
</details>
</br>

##### The Release Specification file

The container images used in the application manifest, are not harcoded in the application manifest.
Instead, they are linked to a file called `spec.yaml` using key values, as follows:

`./1.0/spec.yaml`
```yaml
---
version: 1.0
images:
  IMAGE_NEXUS3: docker.io/sonatype/nexus3:latest
  IMAGE_ARTISAN_REGISTRY: quay.io/gatblau/artisan-registry:latest
...
```

In this way, the `spec.yaml` file provides a way to define the **version** of a release.
Aditionally, if placed under a folder named after the version, can be automatically loaded by the _**Artisan**_ CLI
when generating deployment definitions.

!!! note
      _the `spec.yaml` file must be placed in a folder named `1.0` which corresponds to the version in the application manifest above; so that it can be automatically linked to the  app manifest by the art CLI_

##### Service Manifests

A service is an application process which  runs in a container.  Instead of describing the deployment configuration of
the service for a particular platform, _**Artisan**_ provides a way to describe what a service needs to run.
This includes environment variables, network or storage resources that are part of the service manifest.

The following manifests are used in the application manifest above:

<details><summary><b>./svc/artreg-app.yaml</b></summary>
<p>

```yaml
---
name: artreg-app
description: the artisan registry process
# exposed over the port below
port: "8080"
# requires the following environment variables to be defined
var:
  - name: OXA_HTTP_UNAME
    description: the username to authenticate with the registry HTTP API service
    value: "admin"
  - name: OXA_HTTP_PWD
    description: the password to authenticate the registry HTTP API service
    secret: true
    # variable values can be resolved dynamically at the time the various services are wired together in an 
    # application manifest profile. 
    # For example, the syntax below allows the transpilation process to fetch the value of an environment variable 
    # used in another service and replace it as the value in this service. This allows to "wire" variables across 
    # services that form part of a complex micro service application.
    value: ${bind=nexus-app:var:NEXUS_ADMIN_PASSWORD}
  - name: OXA_HTTP_PORT
    description: the port on which the registry HTTP API service listens
    value: ${bind=artreg-app:port}
  - name: OXA_HTTP_BACKEND_DOMAIN
    description: the URI of the HTTP backend service to use
    value: "http://${bind=nexus-app}:${bind=nexus-app:port[http]}"
  - name: OXA_HTTP_BACKEND
    description: the type of backend service used by the registry to store packages
    value: "Nexus3"
  - name: OXA_HTTP_UPLOAD_LIMIT
    description: the maximum size of artisan packages (in MB) allowed to be pushed to the registry
    # variables can be defined to have specific fix values
    value: "150"
  - name: OXA_HTTP_UPLOAD_IN_MEM_SIZE
    description: the maximum size of the payload (in MB) that is handled in memory with the remaining portion stored in the file system
    value: "150"

# the section below tells the CLI to execute one or  more scripts after services have started to initialise them
# the execution is filtered by the type of builder used (i.e. in this case the compose builder)
init:
  - builder: compose
    scripts:
      - create_artisan_repo

# the section below defines the content of scripts defined in the  init section above
scripts:
  - name: create_artisan_repo
    description: |
      create new artisan hosted repository in nexus
    runtime: ubi-min
    content: |
      echo "creating new artisan hosted repository in nexus"
      art curl -X POST \
        -u admin:${bind=nexus-app:var:NEXUS_ADMIN_PASSWORD} \
        http://${bind=nexus-app}:${bind=nexus-app:port[http]}/service/rest/v1/repositories/raw/hosted \
        -H 'accept: application/json','Content-Type: application/json' \
        -d '{
        "name": "artisan",
        "online": true,
        "storage": {
          "blobStoreName": "default",
          "strictContentTypeValidation": true,
          "writePolicy": "allow"
        },
        "cleanup": {
          "policyNames": [
            "string"
          ]
        },
        "component": {
          "proprietaryComponents": true
        },
        "raw": {
          "contentDisposition": "ATTACHMENT"
        }
      }'
...

```

</p>
</details>


<details><summary><b>./svc/nexus-app.yaml</b></summary>
<p>

```yaml
---
name: nexus-app
description: Nexus 3 repository manager
port:
  http: "8081"
  docker-http: "5000"
  docker-https: "5001"
var:
  - name: NEXUS_ADMIN_PASSWORD
    description: the nexus admin password
    secret: true
    value: ${fx=pwd:16,false}
  - name: SETUP_DOCKER_REGISTRY
    description: Whether to setup docker registry with in Nexus.
    value: true    
volume:
  - name: nexus-data
    path: /nexus-data
init:
  - builder: compose
    scripts:
      - read_default_password
      - setup_nexus
scripts:
  - name: read_default_password
    description: |
      reads Nexus' default admin password from within the container's file system
      using docker exec command and writes the content to a temporary file
      note: this process should run outside of a container, as it needs to call the docker exec command
    content: |
      echo "waiting for nexus process to create default admin password, please wait..."
      DEFAULT_PWD=
      while [ -z "$DEFAULT_PWD" ]
      do
        sleep 1
        DEFAULT_PWD=$(docker exec ${bind=nexus-app} cat /nexus-data/admin.password 2>/dev/null)
      done
      echo $DEFAULT_PWD > temppwd
  - name: setup_nexus
    description: |
      updates the nexus default admin password, disables anonymous access and
      creates a hosted repository required by the artisan registry
      note: this process should run within a container attached to the application network
    runtime: ubi-min
    content: |
      DEFAULT_PWD=$(cat temppwd)
      echo "waiting for nexus to come online, ignore errors, please wait..."
      art curl -X GET \
        -a 25 \
        http://${bind=nexus-app}:${bind=nexus-app:port[http]}/service/rest/v1/status \
        -H 'accept: application/json'

      echo "updating admin password"
      art curl -X PUT \
        -u admin:${DEFAULT_PWD} \
        http://${bind=nexus-app}:${bind=nexus-app:port[http]}/service/rest/v1/security/users/admin/change-password \
        -H 'accept: application/json','Content-Type: text/plain' \
        -d "${bind=nexus-app:var:NEXUS_ADMIN_PASSWORD}"

      rm temppwd

      echo "disabling nexus anonymous access"
      art curl -X PUT \
        -u admin:${bind=nexus-app:var:NEXUS_ADMIN_PASSWORD} \
        http://${bind=nexus-app}:${bind=nexus-app:port[http]}/service/rest/v1/security/anonymous \
        -H 'accept: application/json','Content-Type: application/json' \
        -d '{"enabled": false}'
      
      if ${bind=nexus-app:var:SETUP_DOCKER_REGISTRY} ; then
        echo "creating new artisan docker registry in nexus"
        art curl -X POST \
          -u admin:${bind=nexus-app:var:NEXUS_ADMIN_PASSWORD} \
          http://${bind=nexus-app}:${bind=nexus-app:port[http]}/service/rest/v1/repositories/docker/hosted \
          -H 'accept: application/json','Content-Type: application/json' \
          -d '{
          "name": "docker-registry",
          "online": true,
          "storage": {
            "blobStoreName": "default",
            "strictContentTypeValidation": true,
            "writePolicy": "allow"
          },
          "cleanup": {
            "policyNames": [
              "string"
            ]
          },
          "component": {
            "proprietaryComponents": true
          },
          "docker": {
            "v1Enabled": false,
            "forceBasicAuth": true,
            "httpPort": ${bind=nexus-app:port[docker-http]},
            "httpsPort": ${bind=nexus-app:port[docker-https]}
          }
        }'
      fi
...
```

</p>
</details>
</br>

##### Generating deployment scripts

If applications are defined in terms of services and versions using the generic manifests described before, _**Artisan**_ can automatically generate all resources required to deploy those services on a specific platform.

The advantage of this approach is that regardless of the platform or deployment toolchain, _**Artisan**_ can produce the required scripts consistently and repeatably (providing a builder for the platform/toolchain is available).

Using the scripts above and positioned in the root folder where the files are, you can run the following command:

```bash
# generate deployment scripts for docker compose in the artreg subfolder
$ art app -f compose -p artreg .

# navigate to the folder where the generated scripts are
$  cd ./artreg

# list the folder content
$ ls ./artreg
```

Now, and assuming you have artisan, docker and docker-compose installed on the host, you can launch the registry services as follows:

```bash
# launch the compose services
$ art run deploy

# list containers running
$ docker ps

# dispose all services
$ art run dispose
```

#### Application Releases

[ [go to the top](#artisan) ]

Enterprise applications, especially containerised microservice ones, are made of multiple assets.
These assets fall into one or more of the following categories:

1. Container Images
2. Deployment scripts (e.g. helm charts, shell scripts, ansible playbooks, etc.)
3. Deployment Tools (e.g. docker, helm, ansible, bash, etc.)
4. Operating system packages (e.g. such as debian packages, RPM packages, etc.)
5. Other files (e.g. plain text, yaml, json, binaries, etc.)

Each of the above assets could have their own version (and dependencies) and potentially different development lifecycles.

When deploying enterprise applications, it is important to control their version, which in turn could be represented by a list of versions of its constituting assets.

!!! important ""
      _**Artisan** uses `spec.yaml` files to describe the list of the assets (and their versions) that form a specific enterprise application release_

In addition, these applications are  likely to be deployed on secure networks with limited or no connectivity to the public internet.

This means that all application resources, of whatever kind, should ideally be extracted and packaged in a format that could be easily transferrable across networks, as a single versioned unit of work, for deployment purposes.

#### The release packaging process

In order to create an application release with _**Artisan**_, one can follow the generic process below:

1. Create a `spec.yaml` file that contains:
    - an overall release version
    - a list of one or more _**Artisan**_ package `name:tags`
    - a list of one or more container image `name:tags`
2. Pull the packages/images, described in the `spec.yaml` file, from the respective package/container registries where they have been published
3. Export the packages/images to digitally signed tarbal archive files
4. Upload the exported archives to a version folder within an S3 bucket


<details><summary><b>Release steps</b></summary>
<p>
</br>

Given the `spec.yaml` below:
```yaml
---
# the overall version of the application
version: 1.0

# the list of artisan packages in the release (version tags latest should be replaced with the specific version tag)
packages:
  # contains the deployment scripts for the relevant platform
  PACKAGE_ARTISAN_REGISTRY: my-art-reg.com/apps/artisan-registry:latest

# the list of container images in the release (version tags latest should be replaced with the specific version tag)
images:
  IMAGE_NEXUS3: docker.io/sonatype/nexus3:latest
  IMAGE_ARTISAN_REGISTRY: quay.io/gatblau/artisan-registry:latest
...
```

Execute the following commands:

```bash
# pull artefacts from registries (assume command line prompt is in the directory 
# where spec.yaml is located)
$ art pull .

# exports assets defined in the spec.yaml file to tar archives 
# and upload them to an authenticated and TLS enabled s3 bucket
$ art spec export -o s3s://endpoint/bucket -c S3_ID:S3_SECRET .
```

</p>
</details>
</br>