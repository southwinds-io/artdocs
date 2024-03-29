![artisan](../img/artisan.png){ align=right width=100 }

# Users

If you want to use Artisan Enterprise, then you need a valid license. 
Licenses can be requested to [SouthWinds Tech Ltd](https://southwinds.io/page/contact){ target=_blank } via email.

Once a license has been issued, a license number and a license password will be provided.

Using them you can create users. 

In contrast to Artisan Community, Artisan Enterprise is aware of
the user under who is running. This is so that it can:

1. Attach the user's digital signature to a package that is being built.
2. Verify a package's signature when it is run.
3. Determine if a build, run, open and / or sign policy allows the user to perform such operations.
4. Request package encryption keys at build time.
5. Request package decryption keys at package run time.
6. Confirm license validity.

Once a user has been created, a **pass code** is issued to request Identity tokens.

For security reasons, Artisan does not keep information about the user on a device, but instead 
it can hold securely one or more identity tokens. 

Each token has an expiration time after which it must be renewed.

!!! note
    _The list of commands available in Artisan Enterprise changes depending on
    whether a token has been acquired on the device.
    Without one, the list is limited to only the basic administration commands 
    (i.e. create users and acquire tokens to activate the CLI command list)._

## Creating a user

To create a user an administrator of your organization can use the following command 
taking care of replacing the relevant values according to your circumstances:

```bash
$ art adm user new 
       -r \ 
       -b \
       -n "Bob Jenkins" \
       -e "bob.jenkins@example.com" \
       -l "44ae3030-dedc-4693-8154-bd6937c50056" \
       -p "HLCEDJBixjCuVlfuVxdtNQ2jsqUvYJetB6KsVc6WQInDv9Dx73"
```

where:

- `r`: means the user should be allowed to run packages
- `b`: means the user should be allowed to build packages (note: not all users build packages, for example an operational user for managing an endpoint would not normally build packages but just run them)
- `n`: the friendly display name of the user
- `e`: the email of the user. It must be valid, as artisan will validate it before it can be used.
- `l`: license number that would have been given to you by SouthWinds Tech
- `p`: the license password that would have been given to you along with the license number

!!! note
    _Users should be created by the organization admins in charge of keeping the license details._

If the command is successful, you will be presented with the user information below:

```bash
--[ user account details ]---------------------------------------
 authority : https://notary.artisan.gdn
 license   : 44ae3030-dedc-4693-8154-bd6937c50056 
 name      : Bob Jenkins
 email     : bob.jenkins@example.com
 runnable  : true
 buildable : true
 pass-code : Y1RdwALjPC6mTlQL5CiFCqbbGKCJ9MxOYsnaXUwhmKYTCAbw25
 created   : Wed, 07 Sep 2022 12:54:21 +0100
------------------------------------------------------------------
```

Make a safe copy of this information as it will be needed by the user to request _identity tokens_.

!!! important "Validation of user's email address"
    _Artisan uses only real email addresses. Therefore, it needs to verify
    the address is valid, in good working order and, it belongs to the user._<br>
    To this extent, an email is sent to the user shortly after creating the user account.
    If the user does not validate their email, within a short period of time, by clicking on the link sent, they will be automatically deleted
    and a new user will have to be created.


!!! note
    Depending on the configuration of your mail system, the verification email may go into your junk folder.

## Acquiring Identity Tokens

To activate Artisan on a device, it is necessary to acquire a valid identity token.

This is achieved by issuing the following command on the device where Artisan is running:

```bash
$ art adm token new 
       -x 30 \ 
       -e "bob.jenkins@example.com" \
       -p "Y1RdwALjPC6mTlQL5CiFCqbbGKCJ9MxOYsnaXUwhmKYTCAbw25"
```

!!! note
    A build policy can be specified when requesting a token using the `-b` flag.
    The policy is a regex that can limit the owner of the token to building only particular package names.

To check the token is active:

```bash
$ art adm token ls
```

should display a list of tokens in the device, their expiration time and the user that own them.
Additionally, there will be an indication of which token is active.

The list of commands will now show all available commands, this can be seen by doing:

```bash
$ art
```

Any operation performed by Artisan will be done under the user owning the active token.

### Floating Tokens

By default, the Identity Token is locked to the device that requested it, using the MAC address of its sprimary network interface.
This is done from a security perspective to prevent an unauthorized user from copying the token store onto another device to activate artisan.

However, there are cases where the MAC address on the device is dynamically allocated, for example, when a new user session is created. This is the case, for example, when using the [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/).
In these cases, the token is invalidated everytime the MAC address changes on the device, and a new token has to be requested.

Alternatively, you can request a less secure, floating  token - i.e. not locked to the device, by using the `--float` flag as follows:

```bash
$ art adm token new 
       --float \
       -x 30 \ 
       -e "bob.jenkins@example.com" \
       -p "Y1RdwALjPC6mTlQL5CiFCqbbGKCJ9MxOYsnaXUwhmKYTCAbw25"
```

## Token Expiration

Tokens are set to expire after a number of days. By default, when requesting a token, its duration is set to 10 days.

This can be changed using the `-x` flag in the  `art adm token new` command.

Once a token has expired, Artisan automatically deactivates and cannot longer be used.

## Renewing tokens

A  token can be renewed at any time simply by requesting a new token.

In the same way, the user under which Artisan is running can be changed  by requesting a new token for the intended user.

## Using Network Functions

Artisan Enterprise allows to run packages on remote devices using the network service. 
If you intend to use network commands in Artisan, you must enable the network service as [explained here](network_service.md).