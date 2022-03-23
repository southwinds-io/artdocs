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

The current I.T. landscape is complex. Over the time, applications have transitioned from monoliths to services, to micro services.

To deal with the resulting increasingly complex configurations, new tools have emerged within the umbrella of _infrastructure as a code_. Additionally, _container platforms_ have also appeared, as a solution to deal with modern applications operational requirements.

Despite the power of these individual tools and platforms, organisations still need to deal with a plethora of technologies and configuration options.

In the context of [DevSecOps](https://en.wikipedia.org/wiki/DevOps#DevSecOps,_Shifting_Security_Left) practices, standardisation means that all development, security and operational teams can combine toolchains and execute them in the same consistent and secure way, regardless of the stage in the [application development lifecycle](https://en.wikipedia.org/wiki/Systems_development_life_cycle).

Although this is technologically possible, without a consistent set of standards and abstractions that guide the way logic and tools are packaged, distributed and consumed across a plethora of automation vendors, teams usually find themselves "reinventing the wheel" for every new project and have to manage more than one toolchain in different ways.

!!! important ""
      **_Artisan_** provides a standard approach to publish and consume automation (regardless of the tool selected), via **_Artisan_** packages and registries.

## How Artisan packages compare to container images?

**_Artisan_** packages are created in a similar way as container images. Once created, they can be tagged, pushed to and pulled from an **_Artisan_** registry.

However, **_Artisan_** packages are smaller than container images, and are designed to be deployed in a container at runtime, as well as to run as is in a host.

This allows for the creation of runtime libraries consisting of standard container images with specific toolchains.

Packages are the logic and containers are the environment where the logic runs.

!!! note
      By separating logic and containers at build time and combining them at runtime complex flows can be easily created to execute any combination of packaged functions interchanging pre-configured runtimes.

## Standard but flexible

Sometimes standardisation is associated with opinionated and inflexible. **_Artisan_** tries hard to be flexible by placing the control in the hands of the developers.

**_Artisan_** runs commands from a configuration file - i.e. the build file. This file allows developers to inject instructions at key parts of the process, telling **_Artisan_** what to do, and thus providing the freedom to customise the execution logic. **_Artisan_** then takes these instructions and execute them in a well defined, secure and standard process.

## Secure by default

Cryptography is hard, so **_Artisan_** puts the emphasis on making cryptographic operations seamless, easy to use and implicitly engrained in the fabric of packages.

!!! note
    Using [Pretty Good Privacy (PGP)](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) keys by default, **_Artisan_** can automatically validate that the package being executed comes from a trusted source and it is safe to run.

## Embedded SOPs

When companies onboard new employees or team members, they need to go through a learning curve before they can be effective at their jobs. Time is always in short supply for training.

Standard Operating Procedures (SOP) are documents that contain the necessary instructions to complete critical processes.

SOPs ensure that a business can keep running smoothly as employees come and go, thus providing business continuity.

!!! hint
      **_Artisan_** embeds SOPs in packages making them easy to distribute and readily available to operators.

## Core Subsystems

Artisan achieves all the above by combining the functions in the following core subsystems:

1. [the packaging subsystem](#packaging-subsystem) packages and unpackages files using [zip](https://en.wikipedia.org/wiki/ZIP_(file_format)) archiving and compression format.

2. [the run subsystem](#run-subsystem) defines and calls functions either within packages or on the file system.

3. [the publishing subsystem](#publishing-subsystem) provides the means to tag, push, pull and open packages, enforcing the cryptographic verification of author/source and package integrity checks.

4. [the input subsystem](#input-subsystem) to improve usability and foster reusability, automation packages must have a standard way to publish and consume variables and generate variable specifications. The input system provides options for automated generation of variable files and loading variables from different sources.

5. [the crypto subsystem](#crypto-subsystem) provides the means to create, import, export, rotate and load [PGP](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) keys, encrypt and decrypt files, and sign and verify packages and check integrity of downloaded packages via package digests.

6. [the app subsystem](#app-subsystem) provides the means to generate application deployment configurations and to package and release container based enterprise applications.

___

### Packaging subsystem

Automation typically comes as a set of disparate files that need to be executed in a particular order using specific toolchains.

This leads to difficulties in:

- _distributing the files in a way that hides the implementation details from the operator; and_

- _ensuring that tampering of the files, either wilfull or unconcious, has not happened before their execution_

#### Automation as components

The packaging subsystem achieves encapsulation by creating a [zip file](<https://en.wikipedia.org/wiki/ZIP_(file_format>) containing all the automation code along with a [manifest](https://en.wikipedia.org/wiki/Manifest_file).

The manifest declares the functions that can be executed on such package as well as the their signature, i.e. the inputs required by such function).

!!! hint
      This model simplifies the signing, distribution and execution of automation and reduces the storage and bandwidth requirements for their distribution.

#### Automation as applications

Automation should be treated as a software application and subjected to the same software development lifecycle. This lifecycle means testing and publishing the automation like an application; in a way that can be used by an operator as a [black box](https://en.wikipedia.org/wiki/Black_box).

#### Simple to run for an operator

Operators can be trained to execute the automation but do not necessarily understand how the automation code has been put together or what are the required automation toolchains.

Therefore, there is a need for [encapsulation](https://en.wikipedia.org/wiki/Encapsulation_(computer_programming)), a term coined in the object-oriented programming (OOP) community, that refers to restricting the direct access to some of internal logic that make up a function or component.

___

### Run subsystem

The run subsystem provides a structured framework to run automation scripts and code in general.

#### _**The build file**_

At the core of the run subsystem is the build file: a [YAML file](https://en.wikipedia.org/wiki/YAML) that defines:

- _**functions**_: lists of commands that have to be executed in sequence. For those familiar with GNU Make, _**Artisan**_ functions are similar to [make functions](https://www.gnu.org/software/make/manual/html_node/Functions.html).

- _**profiles**_: the operation(s) required to create _**Artisan**_ packages. In the simplest form they can be just the location of a target folder to zip, in a more complex case, they might involve execution of shell commands or other _**Artisan**_ functions required to prepare the contents of a package.

- _**inputs**_: define the information required by functions and profiles to work. Inputs can be ordinary variables, secrets, (PGP) keys or files.

Build files can be chained, that is, one can call one build file from another build file. This allow to break complex functions in a manageasble way.

_**Artisan**_ has two distinct ways to execute logic, and each of those ways can happen within a container or within a host.

#### _**In Place Execution**_

In place execution is when _**Artisan**_ executes functions or profiles in build files that have not been boxed in a package.

Source code sits in a location in the file system, typically, where the command line terminal prompt is. This is useful mostly for development purposes as execution can be done without creating a package.

!!! hint
    _**Artisan**_ uses _in place execution_ within a runtime that is part of a flow with a git source. If a flow uses a git source, the files have already being mounted in the runtime and pulling package within the runtime, is not required.

!!! note
     **In place execution** can be invoked using the `run` command.

#### _**Package Execution**_

Package execution is when _**Artisan**_ executes functions in a build file that is embedded in the package. This is the way logic is mostly executed in operation environments once a package is released.

!!! hint
      _**Artisan**_ uses _package execution_ within  runtimes, i.e. upon launching a runtime with a toolchain, _**Artisan**_ pulls the relevant package within the runtime and execute the requested function.

!!! note
     **Package execution** can be invoked using the `exe` command.

#### _**Using Runtimes**_

In addition to the two execution modes descussed before, _**Artisan**_ can perform in place or package execution within a linux container in a host with [docker](https://docs.docker.com/get-started/) or [podman](https://podman.io/) installed.

This is useful when the toolchain required to run the automation is not installed on the host.

For example, consider a package that requires [Ansible](https://www.ansible.com/) and you want to run it on a host. As Ansible command line does not work on Windows, _**Artisan**_ can lunch a Linux based Ansible runtime container and execute the logic within it.

!!! hint
     runtimes can be used with both in-place and package execution:

     - use the `runc` command instead of `run` to launch a runtime for in-place execution.
     - use `exec` command instead of `exe` to launch a runtime for package execution.

#### _**Runtimes**_

_**Artisan**_ runtimes are container images that implement a standard execution interface.

Upon creation a bootstrap script within the container calls the _**Artisan**_ _command line interface_ (also inside the container), which in turn, pulls the designated _**Artisan**_ package from a registry and execute the required function.

There are various different container runtimes such as the ones <a href="http://quay.io/artisan/" target="_blank">here</a> with different toolchains. 


!!! caution
    Runtimes must be created in such way that they implement the handshake required by _**Artisan**_.
    It is recommended that custom runtimes are based on [runtime based images](https://github.com/gatblau/artisan/tree/master/runtime/base). These base images ensure the runtime follows the interface required by _**Artisan**_ to run the package logic.

#### _**Flows**_

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

A runner is an HTTP service that is in charge of the execution a package function or a flow.

___

### Publishing subsystem

The publishing subsystem goal is to facilitate the distribution of packages and the dynamic installation of packages into hosts and runtimes.

The _**Artisan**_ CLI can create, tag and push packages to an _**Artisan**_ registry. Once there, packages can be pulled and published functions can be run.

At the heart of the publishing subsystem is the Artisan Registry.

#### _**The Artisan Registry**_

In a similar way to a [Docker registry](https://docs.docker.com/registry/), the _**Artisan**_ Registry is a stateless, highly scalable server side application that stores and lets you distribute _**Artisan**_ Packages.

The registry can sit in front of various backends, such as a [Nexus Repository](https://www.sonatype.com/nexus/repository-pro).

The registry is typically released as a container image which can run from any [Kubernetes](https://kubernetes.io/) implementation.

##### _**Discoverable Library**_

The _**Artisan**_ Registry can be used to implement an enterprise wide library made of digitally signed, black boxed and discoverable packages that can be ubiquitously run in hosts or container runtimes, fully encapsulating their implementaion details and underlying toolchains.

Packages in the library can be mixed and matched using flows, to cater for a wide range of complex Enterprise automation scenarios.

___

### Input subsystem

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

_**Artisan**_ uses PGP encryption to digitally sign every package. A private key is used to sign packages.

In the same way, any package that is executed must pass the verification of its digital signature before they can do so. The counterpart public key is used to verify the package signature.

_**Artisan**_ can create PGP keys, and has a local registry where keys can be placed. The registry allows to place keys in a hierarchical structure to facilitate overriding following the package group/name convention.

For example placing a key in the root make it usable to sign/verify all packages, where as placing a key withing a specific group and or name make the key usable within that package group or name.

___

<a name="flow_footnote">[1]</a> _Artisan flows are [yaml files](https://en.wikipedia.org/wiki/YAML) that simply describe a sequence of execution steps. They can be thought of as a logical pipeline and the emphasis is to make them human readable. An Artisan Runner then takes a flow and transpile it to the physical environment format where they run. For example, an Artisan Runner in Kubernetes transpiles the flow into a [Tekton](https://tekton.dev/) pipeline._

<a name="digi_seal_footnote">[2]</a> _The digital seal is part of an Artisan package. It is a json file that contains the package manifest and a digital signature for the combination of the package manifest and the package zip file._
