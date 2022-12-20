DEFAULT_OPTS=-e HYPRIOT_HOSTNAME -e HYPRIOT_GROUPNAME -e HYPRIOT_USERNAME -e HYPRIOT_PASSWORD

default: build

build:
	docker build -t rootfs-builder .

all: build amd64 i386 arm64-debian armhf-debian mips armhf-raspbian

amd64: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=amd64 -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder

i386: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=i386 -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder

arm64-debian: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=arm64 -e QEMU_ARCH=aarch64 -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder

armhf-debian: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=armhf -e QEMU_ARCH=arm -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder

armhf-raspbian: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=armhf -e QEMU_ARCH=arm -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -e VARIANT=raspbian -v $(shell pwd):/workspace --privileged rootfs-builder

mips: shellcheck
	docker run --rm $(DEFAULT_OPTS) -e BUILD_ARCH=mips -e QEMU_ARCH=mips -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder

shell: build
	docker run --rm -ti -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace --privileged rootfs-builder bash

test: build
	docker run --rm -ti $(DEFAULT_ENV) -e BUILD_ARCH=$(BUILD_ARCH) -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -e VARIANT -v $(shell pwd):/workspace --privileged rootfs-builder /builder/test.sh

testshell: build
	docker run --rm -ti -e CIRCLE_TAG -e HYPRIOT_OS_VERSION -v $(shell pwd):/workspace -v $(shell pwd)/test:/test --privileged rootfs-builder bash

shellcheck: build
	docker run --rm -ti -v $(shell pwd):/workspace rootfs-builder bash -c 'shellcheck builder/*.sh'

tag:
	git tag ${TAG}
	git push origin ${TAG}
