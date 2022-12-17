# hypriot-os-rootfs

[![CircleCI](https://circleci.com/gh/barthel/hypriot-os-rootfs.svg?style=svg)](https://circleci.com/gh/barthel/hypriot-os-rootfs)

The `hypriot-os-rootfs` builds the base of all the HypriotOS images.
This repo creates a general root filesystem for different CPU architectures without the board specific parts.

This root filesystem

* uses a minimal Debian system
* adds an user pirate
* sets a default locale (UTF-8)
* sets a default timezone (UTC)
* ...

## Contributing

You can contribute to this repo by forking it and sending us pull requests.
Feedback is always welcome!

You can build the root filesystem locally with Docker.

Create builder Docker image

```
make build
```

Create all rootfs's for all supported ARCH's

```
make all
```

Create single rootfs's for all supported ARCH's

```
make i386
make amd64
make armhf-debian
make armhf-raspbian
make arm64-debian
make mips
```

Run container in interactive mode (for testing purposes)

```
make shell
```

## Build artifacts

The output of the build will be in the current directory as a `rootfs-${ARCH}-${HYPRIOT_OS_VERSION}.tar.gz` file.

## How to run tests

### Option 1: Run tests with a single command
With the following command, all tests for a specific architecture will be executed:

```
BUILD_ARCH=arm64 make test
```

### Option 2: Run tests interactively
If you prefer to have a shorter feedback loop of less than a second, enter the container with

```
make testshell
```

Now, to run the test, execute

```
BUILD_ARCH=arm64 /builder/test.sh
```

### Run shellcheck tests
To run the [shellcheck](https://github.com/koalaman/shellcheck) tests, execute

```
make shellcheck
```

## License

MIT - see the [LICENSE](./LICENSE) file for details.
