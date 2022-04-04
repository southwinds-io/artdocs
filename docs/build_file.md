![artisan](../img/artisan.png){ align=right width=100 }

# The Build file

In the same way that [GNU make](https://www.gnu.org/software/make/) uses a [Makefile](https://www.gnu.org/software/make/manual/make.html#Introduction), you need a file called **build.yaml** (the build file) to tell *Artisan* what to do.

The build file tells *Artisan* how to run `functions`, that is, a sequence of command line instructions.

The build file also tells *Artisan* how to create `packages`. *Artisan* packages are [digitally signed](https://en.wikipedia.org/wiki/Digital_signature) [zip files](https://en.wikipedia.org/wiki/ZIP_(file_format)) containing one or more files and folders.

When a build file is placed within a package, the package becomes `executable`, that is, exported functions in the build file can be executed and use content in the package.

For example, a function in a package that contains a [POM file](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html) could:

- invoke [Maven](https://en.wikipedia.org/wiki/Apache_Maven) to create a [Java](https://en.wikipedia.org/wiki/Java_%28programming_language%29) project using a [Maven archetype](https://maven.apache.org/guides/introduction/introduction-to-archetypes.html); then
- invoke [git](https://en.wikipedia.org/wiki/Git) to push the project to a remote origin

In another example, a function in a package that contains [Ansible roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) could invoke a [playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) to deploy and configure a virtual machine on a public cloud provider.

On more trivial cases, a build file could contain functions to build and package software and create conatiner images.

As the build file is not technology specific, it can be used to build any software with any toolchain, *it is just a command line orchestrator*.

| section | description |
|---|---|
| [*the functions section*](#the-function-section)| describes the syntax for the functions section of the build file |
| [*the input section*](#the-input-section)| describes the syntax used to define inputs in a build file |
| [*the profiles section*](#the-profiles-section) | describes what are build profiles |
| [*the env section*](#the-env-section) | describes how to define repeated configuration values in a single place |
| [*the labels section*](#the-labels-section) | describes how to add labels to a manifest |

## The *functions* section

[ [go to the top](#the-build-file) ]

The *functions* section defines the functions available to call by *Artisan* as well as the commands that need to be executed in the command line when the function is called.

:exclamation: note that input section and function bindings as shown in the example below are explained in the *input* section further down.

The structure of the *functions* section is as follows:

```yaml
---
# define inputs required by functions in the build file
input:
  # define variables 
  var:
    - name: MY_VAR_1
      description: sample variable 1
      type: string

    - name: MY_VAR_2
      description: sample variable 2
      type: string

  # define secrets
  secret:
    - name: MY_SECRET_1
      description: sample secret 1

    - name: MY_SECRET_2
      description: sample secret 2

  # define PGP keys
  key: 
    - name: MY_KEY_1
      description: sample key 1
      private: true

    - name: MY_KEY_2
      description: sample key 2
      private: false

# a list of functions 
functions:
    # how the function will be called
    - name: my-function
      # a meaningful description of the function
      description: |-
        description line 1 here
        description line 2 here
        more lines if needed...
      # a flag to tell Artisan to include the function in the 
      # package manifest (make the function available to 
      # package users to call - i.e. public)
      export: true
      # a list of commands to be invoved sequntially
      run:
        - echo "command 1 here"
        - echo "command 2 here"

      # binds inputs required by the function
      input:
        # variable bindings
        var: 
           - MY_VAR_1
           - MY_VAR_2
        # secret bindings
        secret:
           - MY_SECRET_1
           - MY_SECRET_2
        # pgp key bindings
        key:
           - MY_KEY_1
           - MY_KEY_2
    
    - name: another-function-here
...
```

## The *input* section

[ [go to the top](#the-build-file) ]

Typically, any complex automation has to be configurable. Configuration in Artisan is managed mostly via environment variables, as this is aligned with the way [linux containers](https://www.redhat.com/en/topics/containers/whats-a-linux-container) work.

Input information required by the build file, is defined in the iput section containing three sub sections as follows:
  
- `var`: these are plain environment variables
- `secret`: these are variables that contain sensitive information like credentials
- `key`: these are the definition of [PGP](https://en.wikipedia.org/wiki/Pretty_Good_Privacy) keys that are used by Artisan to sign and verify packages
- `data`: these are the paths to specific files that should be available at package execution time, but that are not in the package. Typical examples of these are SSH keys that, due to security reasons, should not be part of a package 
but are required when the package is running.

:exclamation: Using different names for the different types of input allows *Artisan* to provide differenciated treatment for each of them.

For instance, secrets are variables that try and hide its value where posiible. Keys are variables but containing PGP keys and typically allow for easy loading, for example fro Artisan local registry.

```yaml
---
input:
  # variables definition below
  var:
    - name: GREETING_VARIABLE
      description: the description for GREETING_VARIABLE that will be used for documentation generation and to advice users if using command line interactive mode.
      # a boolean flag indicating if the variable is 
      # mandatory, it is used for input validation
      required: true
      # the type of the variable for the purpose of validation. 
      # Possible types are: path (a file path), uri (a unique resource identifier), 
      # name (an Artisan package name), string (any string)
      type: string
      default: "hello world"
        
    - name: OTHER_VARIABLES_HERE
  
  # secrets definitions below
  # secrets are variables that are treated as confidential information
  secret:
    - name: MY_USER_NAME
      description: login username

    - name: MY_USER_PWD
      description: login password

  # PGP keys: defines name, description, load path and whther they are private or not
  key:
    - name: MY_PUBLIC_KEY
      description: "I use this key to verify a digital signature"
      # is it private or public?
      private: false
      # what is the default path for the key in the local
      # Artisan registry
      path: /
...
```

:checkered_flag: **try it!**

```bash
# run the function say-hello in the build file located at examples/10 folder
$  art run say-hello examples/10
# you should see
Hello World
```

### Binding variables

[ [go to the top](#the-build-file) ]

Variables must be bound to a function to tell *Artisan* that the variable is needed by such function.

This is mostly required when a function is exported so that its required inputs can be added to the package manifest.

:exclamation: this will be clarified when Artisan packages are discussed.

Bindings are written using a similar syntax to the input definition. The following example ilustrates how to bind the **USER_TO_GREET** variable to the **greet-user** function:

```yaml
---
input:
   # variable definition section
   var: 
     - name: USER_TO_GREET
       description: the name of the user to greet
       required: true
       default: Gatblau
       type: string

functions:
    - name: greet-user
      run:
        - echo Hello ${USER_TO_GREET}!
      input:
         # variable binding section
         var:
           - USER_TO_GREET
...
```

:checkered_flag: **try it!**

```bash
# the following example assumes Linux/OSX operating system:

# tell Artisan to run the "greet-user" function from the 
# build file located at the "examples/20" sub-folder
$  art run greet-user examples/20 

# you should see an error message as the variable 
# USER_TO_GREET is not defined
error!
* USER_TO_GREET is required

# now try interactive mode, so the command line interface 
# will ask you to enter the missing variables
# note the -i flag to tell Artisan to run in interactive mode
$  art run -i greet-user examples/20

# you should be able to see the following prompt
# note the default value in brackets
? var => USER_TO_GREET (the name of the user to greet): (Gatblau) 

# press enter to use the default value
# you should now see the message below
Hello Gatblau!

# now export an environment variable 
$ export USER_TO_GREET="Mickey Mouse"
$ art run greet-user exampless/20
  
# you should now see the message below
Hello Mickey Mouse!

# now unset the variable USER_TO_GREET
$ unset USER_TO_GREET

# Artisan can also load variables from a file
# the file can contain one or more environment variables
# to test it, create an environment file as follows
$ echo USER_TO_GREET="Black Pete" >> examples/20/.env

# now try and run the command below
# note the -e flag to tell Artisan to load the 
# new environment file
$ art run -e examples/20/.env greet-user examples/20

# you should see the following message
Hello Black Pete!
```

### Unbound variables

[ [go to the top](#the-build-file) ]

In some cases, you might not want to create a binding but still want Artisan to prompt for the value of a variable if missing. This is normally the case when you do not intend to export functions but still want to run them locally.

In this case, the build file would simply look like the following:

```yaml
---
functions:
  - name: greet-user
    run:
      - echo Hello ${USER_TO_GREET}!
...
```

:checkered_flag: **try it!**

```bash
$ art run greet-user examples/30

# you should see the following message
error!
* the environment variable 'USER_TO_GREET' is not defined, are you missing a binding? you can always run the command in 
  interactive mode to manually input its value

# now try and do the following and observe what happens:
# 1. run Artisan in interactive mode (use the -i flag)
# 2. export the required variable
# 3. load the variable from an environment file (use the -e flag)
```

## The *profiles* section

[ [go to the top](#the-build-file) ]

The *profiles* section defines the package build profiles, that is, the set of instructions required by *Artisan* to create packages.

In its simplest way, a build profile requires a target folder where the files that have to be packaged.

:checkered_flag: **try it!**

You want to package arbitrary files located in the source folder [here](examples/40/source).

Define a profile in the build file as follows:

```yaml
---
profiles:
  - name: package-it
    type: files
    description: packages any files in the target folder
    target: ./source
...
```

Then navigate to the folder [here](examples/40) and run the following command:

```bash
# simplest command to build a package
art build -t mypack 

# check if the package was created by listing packages in the local registry
art ls

# the output should be
REPOSITORY                    TAG      PACKAGE ID    PACKAGE TYPE  CREATED          SIZE
artisan.library/root/mypack   latest   9cd5c9bbc59d  files         14 seconds ago   454B
```

Now open the package in a folder of your choice:

```bash
# open the contents of the package in a new test folder
art open mypack ./test

# list the folder content
ls -la ./test

# you should see
-rw-r--r--  1 user  staff   11  8 May 09:03 file_01.txt
-rw-r--r--  1 user  staff   11  8 May 09:03 file_02.tx
```

More complex profiles will be explained in the [packages](package.md) section.

## The *env* section

[ [go to the top](#the-build-file) ]

The `env` section allows users to define environment variables that can be used by any functions and profiles.

In addition, variables can be defined within functions, to override the globally defined variables.

The main use case is to reduce variable duplication within a build file.

For example consider the following build  file:

```yaml
---
env:
  # compiler general configuration flags
  CGO_ENABLED: 0
  GOARCH: amd64
  # the application version
  APP_VERSION: 1.0.4
  # a unique build number from the variable defined above and the unique artisan 
  # build reference (automatically generated by the build process)
  BUILD_VERSION: ${APP_VERSION}-${ARTISAN_REF}

functions:
  - name: build-linux
    description: build a golang app for linux injecting autogenerated version number in code
    env:
      # add additional variable only valid within this function
      GOOS: linux
    run:
      - go build -ldflags="-X 'Version=${BUILD_VERSION}'" -o my-app -v
```

```yaml
  - name: build-darwin
    description: build a golang app for MacOSX injecting autogenerated version number in code
    env:
      # add additional variable only valid within this function
      GOOS: darwin
    run:
      - go build -ldflags="-X 'Version=${BUILD_VERSION}'" -o my-app -v
```

Here two different functions, `build-linux` and `build-darwin`, use the configuration in the `env` section at the top of the build file but override the specific `GOOS` variable at the  function level.

If, for example, there was a need to update the build architecture `GOARCH`, say from `amd64` to `arm64` there is only a single place to change it, hence reducing code duplication and improving script maintenance.

### Auto-generated variables

[ [go to the top](#the-build-file) ]

The _**Artisan**_ run process automatically inject the following variables to the execution context:

| variable | description |
|---|---|
| ARTISAN_REF | a unique identifier made of `timestamp`-`commit-head`. <br> If no git repo is available, then the commit head is blank.|
| ARTISAN_BUILD_PATH | the path where the build process happens |
| ARTISAN_GIT_COMMIT | the current git commit |
| ARTISAN_WORK_DIR | the working directory |
| ARTISAN_FROM_URI | the URI where the source of the build process is |

To test these variable try the following:

```yaml
---
functions:
   - name: ref
     run: echo ${ARTISAN_REF}
...
```

And then:

```bash
$ art run ref
ART INFO: 20220331210233507-a6b5668a49
```

### Deriving variables from inputs

[ [go to the top](#the-build-file) ]

In same cases, it is useful to defined a variable that is derived from an input to the build file.
This happens when one or more input values dictate the value of other variables and you want to automatically generate
them so that there is no scope for error.

For example, you have an URI that should be generated from the value of an input.

Given the input `INPUT_VARIABLE`, then `DERIVED_VARIABLE` can be created in the `env` section of the build file as follows:

```yaml
---
env:
  # the derive variable is made up of the content of an input variable
  DERIVED_VARIABLE: aaa/${INPUT_VARIABLE}/ccc

input:
  var:
    # define the input variable
    - name: INPUT_VARIABLE

functions:
  - name: derive
    description: echo the value of the derived variable
    run:
      - echo ${DERIVED_VARIABLE}
    input:
      # add a binding to inform artisan INPUT_VARIABLE must be surveyed
      var:
        - INPUT_VARIABLE
...
```

To run the example copy the build.yaml to a file and run the command below:

```bash
# run the derive function in interactive mode to collect INPUT_VARIABLE
$ art run derive -i
? var => INPUT_VARIABLE (): HELLO
ART INFO: aaa/HELLO/ccc
```

!!! note
    _`INPUT_VARIABLE` can also be defined in an `.env` file in the same directory as the build file. In this case, it is automatically loaded in the artisan context and the command above does not need to run in interactive mode_

### Using subshell expressions within variables

[ [go to the top](#the-build-file) ]

It is possible to run a subshell within a variable to fetch information from the subexpression.

For example, given an `info.txt` file like so:

```text
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut eu sem integer vitae justo eget. Morbi quis commodo odio aenean 
sed adipiscing diam donec adipiscing. Massa eget egestas purus viverra. Massa ultricies mi quis 
hendrerit dolor magna eget est. Dui sapien eget mi proin sed libero enim sed. 
```

And a `build.yaml` file like so:

```yaml
---
env:
  CONTENT: $((cat info.txt))

functions:
  - name: echo
    run:
      - echo ${CONTENT}
...
```

Running the `echo` function will read the file and echo its content:

```bash
$ art run echo
ART INFO: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
dolore magna aliqua. Ut eu sem integer vitae justo eget. Morbi quis commodo odio aenean sed adipiscing diam donec
adipiscing. Massa eget egestas purus viverra. Massa ultricies mi quis hendrerit dolor magna eget est. Dui sapien 
eget mi proin sed libero enim sed. 
```

!!! note
    _the subshell expression syntax is **$(( `command here` ))**_

## The *labels* section

[ [go to the top](#the-build-file) ]

Labels let you attach arbitrary metadata to _**Artisan**_ packages.

Labels are added at the time a package is built. They cannot be modified after the initial creation; you need to rebuild the package to modify them.

Labels are key value pairs defined in the build file as follows:

```yaml
---
# labels defined at a global level
labels:
  author: southwinds.io
  description:  artisan documentation

profiles:
  - name: doc
    default: true
    # additional labels for the profile
    labels:
      platform: linux
    target: test
...
```

Given a `./test/docs.md` file in a test folder with content like so:

```markdown
# this is the doc title

this is the doc content
```

```bash
# build the package
$ art build -t test -p doc .

# print the manifest
$ art manifest test
```

Labels should be displayed in the output manifest.