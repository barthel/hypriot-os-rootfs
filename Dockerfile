FROM uwebarthel/hypriot-image-builder:v1.1

RUN apt-get update && apt-get install -y \
    binfmt-support \
    gpg \
    gpg-agent \
    qemu \
    qemu-user-static \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY builder /builder/

# create rootfs
CMD /builder/build.sh
