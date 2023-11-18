ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG IMAGE_SUFFIX="${IMAGE_SUFFIX:-main}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-38}"

FROM ghcr.io/ublue-os/${IMAGE_NAME}-${IMAGE_SUFFIX}:${FEDORA_MAJOR_VERSION}

ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-38}"

COPY etc /etc
COPY usr /usr
COPY packages.json /tmp/packages.json
COPY build.sh /tmp/build.sh
COPY github-release-install.sh /tmp/github-release-install.sh

## bootc
RUN wget https://copr.fedorainfracloud.org/coprs/rhcontainerbot/bootc/repo/fedora-"${FEDORA_MAJOR_VERSION}"/bootc-"${FEDORA_MAJOR_VERSION}".repo -O /etc/yum.repos.d/bootc.repo && \
    rpm-ostree install bootc && \
    rm -f /etc/yum.repos.d/bootc-"${FEDORA_MAJOR_VERSION}".repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/bootc.repo

# packages
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh

# latest distrobox-assemble (exported_{app,bin})
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-assemble /usr/bin/distrobox-assemble

# finalize
RUN systemctl enable dconf-update.service && \
    systemctl enable rpm-ostree-countme.timer && \
    fc-cache -f /usr/share/fonts/inputmono && \
    fc-cache -f /usr/share/fonts/outputsans && \
    fc-cache -f /usr/share/fonts/sanfran && \
    fc-cache -f /usr/share/fonts/sfmono && \
    sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf && \
    sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf && \
    chmod a+x /usr/share/ublue-os/firstboot/*.sh
    chmod a+x /etc/systemd/user/rclone@.service

# clean up
RUN rm -f /usr/share/applications/htop.desktop && \
    rm -f /usr/share/applications/nvtop.desktop && \
    rm -rf /tmp/* /var/* && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
    
# Commit container
RUN ostree container commit