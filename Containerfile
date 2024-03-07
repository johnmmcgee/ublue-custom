ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-silverblue}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG AKMODS_FLAVOR="${AKMODS_FLAVOR:-main}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$IMAGE_FLAVOR}"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-39}"


FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION}

ARG IMAGE_NAME="${IMAGE_NAME}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR}"
ARG AKMODS_FLAVOR="${AKMODS_FLAVOR}"
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION}"

COPY usr /usr

# ptyxis
RUN if [ ${FEDORA_MAJOR_VERSION} -ge "39" ]; then \
        wget https://copr.fedorainfracloud.org/coprs/kylegospo/prompt/repo/fedora-$(rpm -E %fedora)/kylegospo-prompt-fedora-$(rpm -E %fedora).repo?arch=x86_64 -O /etc/yum.repos.d/_copr_kylegospo-prompt.repo && \
        rpm-ostree override replace \
        --experimental \
        --from repo=copr:copr.fedorainfracloud.org:kylegospo:prompt \
            vte291 \
            vte-profile \
            libadwaita && \
        rpm-ostree install \
            ptyxis && \
        rm -f /etc/yum.repos.d/_copr_kylegospo-prompt.repo \
    ; fi
    
# akmods
COPY --from=ghcr.io/ublue-os/akmods:${AKMODS_FLAVOR}-${FEDORA_MAJOR_VERSION} /rpms /tmp/akmods-rpms
RUN if [ ${FEDORA_MAJOR_VERSION} -ge "39" ]; then \
        rpm-ostree install \
            /tmp/akmods-rpms/kmods/*xpadneo*.rpm \
            /tmp/akmods-rpms/kmods/*xone*.rpm \
            /tmp/akmods-rpms/kmods/*v4l2loopback*.rpm \
            /tmp/akmods-rpms/kmods/*winesync*.rpm \
    ; fi 

# packages
ADD packages.json /tmp/packages.json
ADD packages.sh /tmp/
RUN sh /tmp/packages.sh

# post install (enabled services, fonts, timeouts, firstboot, remove shortcuts, commit)
RUN systemctl enable dconf-update.service && \
    systemctl enable rpm-ostree-countme.timer && \
    fc-cache -f /usr/share/fonts/inputmono && \
    fc-cache -f /usr/share/fonts/outputsans && \
    sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf && \
    sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf && \
    chmod a+x /usr/share/ublue-os/firstboot/*.sh && \
    rm -f /usr/share/applications/htop.desktop && \
    rm -f /usr/share/applications/nvtop.desktop && \
    rm -rf /tmp/* /var/* && \
    ostree container commit && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
