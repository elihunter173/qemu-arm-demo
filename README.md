# qemu-arm-demo

A demo of developing and testing ARM assembly Linux user-mode programs
using [QEMU].

This demo was written with NC State University's CSC 236 - Computer
Organization and Assembly Language for Computer Scientists in mind. However, it
also demonstrates how to set up user-mode emulation of any ARM binary, cross
compilation to ARM for anything GCC supports, how to make Linux syscalls in
assembly, and how to set up CI for all of that!

## Why QEMU?

QEMU supports all major operating systems, can emulate many different ISAs and
processors (not just ARM!), and can be run headless for automated testing.

## Setting Up

Setting up QEMU with the appropriate GCC toolchain should be fairly trivial on
most popular Linux distribution and on Windows using Window's Subsystem for
Linux (WSL). However, if you run into issues with the following instructions, a
`Vagrantfile` has also been provided with all the appropriate tools. Read the
[Vagrant](#vagrant) section for details on how to set that up.

*Note:* All of the instructions below include instructions on how to install
make and [bats]. They are not required, but they do make building and testing
things easier and are used in my example. Feel free to ignore them if you prefer
other tools / doing it manually.

### Debian / Ubuntu

The following command if you run Debian stretch (or later) or Ubuntu 16.04 (or
later) should work.

```sh
$ sudo apt-get install gcc-arm-linux-gnueabihf gdb-multiarch qemu make bats
```

### Windows

To set up your environment on Windows, you must first enable WSL. Follow [this
guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10) if you have
not already enabled WSL. From there, go to the Windows store and download your
Linux distro of choice (Ubuntu is recommended). Now, go to that Linux distro's
set up guide and continue from there.

### Arch Linux

Sadly Arch Linux's main repositories don't contain all the necessary packages
for cross-compiling to ARM. However, the [AUR] does. Run the following command
(replacing `yay` with your AUR helper of choice).

```sh
# Packages in the main repository
$ pacman -S qemu make bash-bats
# Packages in the AUR
$ yay -S arm-linux-gnueabihf-gcc arm-linux-gnueabihf-glibc gdb-multiarch
```

### Vagrant

It is recommended that you use [Vagrant] only as a fall back if the earlier
methods fail (or you use Mac). This is because Vagrant uses VMs, which are more
resource intensive and often less friendly to work with. Luckily, Vagrant helps
mitigate this.

To use Vagrant, first install it for your system. Instructions are available
[here](https://www.vagrantup.com/intro/getting-started/install.html). Once you
have done that, open up a terminal in this repository's root directory and run
the following.

```sh
# In this repo's root directory
$ vagrant up
```

This should take 2-3 minutes to run initially as everything is downloaded and
installed. Subsequent uses should take much less time. Once the VM is up, run
the following to log in to it remotely.

```sh
# In this repo's root directory
$ vagrant ssh
# Now in the VM
$ cd /vagrant
```

Once you have done that, congratulations! You now have a working VM. Vagrant
has automatically mounted this repo's root directory onto `/vagrant`, so you
should be able to see (and edit) all the files in the VM easily.

## Usage

To cross-build your programs, you use the same commands (e.g. `as`, `ld`) that
you normally would but you prefix every command with `arm-linux-gnueabihf-`.
Similarly, for executing you use `qemu-arm <executable>` instead of
`./<executable>`.

Debugging is slightly more complicated because you must connect to `qemu-arm`'s
GDB server through `gdb-multiarch` (not `gdb`!). The easiest way I've found to
is to run the following commands.

```nohighlight
# Start up QEMU with a GDB server on port 1234 in the background
$ qemu-arm -singlestep -g 1234 <executable> &
# Connect to QEMU's GDB server
$ gdb-multiarch
(gdb) target remote localhost:1234
```

Look at `example/` for more details and a concrete set up.

**TODO:** Expand this section.

## Extra Links

* GNU Assembler Reference: <http://tigcc.ticalc.org/doc/gnuasm.html>
* Linux Syscall Numbers for ARM32:
  <https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#arm-32_bit_EABI>
* Linux Syscall Calling Conventions: `man 2 syscall`

[AUR]: https://aur.archlinux.org/
[QEMU]: https://www.qemu.org/
[Vagrant]: https://www.vagrantup.com/
[bats]: https://github.com/bats-core/bats-core
