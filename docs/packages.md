![artisan](../img/artisan.png){ align=right width=100 }

# Packages

An Artisan package is a logical entity that is made of two files:

- A compressed archive file (zip file) containing one or more files of folders.
- A json file, `the digital seal`, containing package information such as author, labels, API, checksum, signature, etc.

These two files are married together by a digital signature and cannot be used in isolation.
From a user's perspective, Artisan handles the two files as a single package.

Packages are created by invoking a profile in a build file.
Once a package is built, it is stored in the local registry under the user home `(i.e. ${HOME}/.artisan/)` and can be listed
using the `ls` command.

A package offers a way of aggregating different I.T. resources, such as scripts, binaries and content files; to facilitate their 
transfer and the execution of the logic inside them.

## Types of Packages

## Building a package

## Running functions in a package

## Package Manifests

## Package Signatures

## Integrity Checks

