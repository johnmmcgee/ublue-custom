ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG IMAGE_SUFFIX="${IMAGE_SUFFIX:-main}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-38}"

FROM ghcr.io/ublue-os/${IMAGE_NAME}-${IMAGE_SUFFIX}:${FEDORA_MAJOR_VERSION}

ARG IMAGE_NAME="${IMAGE_NAME:-silverblue}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-38}"

COPY etc /etc
COPY usr /usr



ADD packages.json /tmp/packages.json
#ADD akmods.sh /tmp/akmods.sh
ADD build.sh /tmp/build.sh
ADD github-release-install.sh /tmp/github-release-install.sh

## bootc
RUN wget https://copr.fedorainfracloud.org/coprs/rhcontainerbot/bootc/repo/fedora-"${FEDORA_MAJOR_VERSION}"/bootc-"${FEDORA_MAJOR_VERSION}".repo -O /etc/yum.repos.d/bootc.repo
RUN rpm-ostree install bootc
RUN rm -f /etc/yum.repos.d/bootc-"${FEDORA_MAJOR_VERSION}".repo

RUN mkdir -p /var/lib/alternatives
#RUN    /tmp/akmods.sh && \
RUN /tmp/build.sh
RUN systemctl unmask dconf-update.service
RUN systemctl enable dconf-update.service
RUN systemctl enable rpm-ostree-countme.timer
RUN sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/bootc.repo
RUN sed -i "s/FEDORA_MAJOR_VERSION/${FEDORA_MAJOR_VERSION}/" /usr/etc/distrobox/distrobox.conf
RUN sed -i "s/FEDORA_MAJOR_VERSION/${FEDORA_MAJOR_VERSION}/" /usr/etc/distrobox/distrobox.ini
RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
RUN sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf
RUN mv /var/lib/alternatives /staged-alternatives
RUN rm -rf /tmp/* /var/*
RUN ostree container commit
RUN mkdir -p /var/lib && mv /staged-alternatives /var/lib/alternatives
RUN mkdir -p /tmp /var/tmp
RUN chmod 1777 /tmp /var/tmp
