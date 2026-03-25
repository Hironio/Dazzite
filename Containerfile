# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
#FROM ghcr.io/ublue-os/bazzite:stable
FROM ghcr.io/ublue-os/bazzite-nvidia:stable


## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### [IM]MUTABLE /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.

# RUN rm /opt && mkdir /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

# --- AGGIUNTA DAZZITE: Risolve l'errore "recipe not found" ---

# 1. Copia il file dallo stage ctx (che punta a build_files/) al sistema
COPY --from=ctx /60-dazzite.just /usr/share/ublue-os/just/60-dazzite.just

# 2. Registra la ricetta nel catalogo ufficiale ujust (Import)
RUN echo 'import "/usr/share/ublue-os/just/60-dazzite.just"' >> /usr/share/ublue-os/just/80-bazzite.just
# -----------------------------------------------------------

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
