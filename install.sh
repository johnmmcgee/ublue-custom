#!/bin/sh
set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

mkdir -p /var/lib/alternatives

# ptyxis
if [ ${FEDORA_MAJOR_VERSION} -ge "39" ]; then \
    wget https://copr.fedorainfracloud.org/coprs/kylegospo/prompt/repo/fedora-$(rpm -E %fedora)/kylegospo-prompt-fedora-$(rpm -E %fedora).repo?arch=x86_64 -O /etc/yum.repos.d/_copr_kylegospo-prompt.repo && \
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:prompt \
        vte291 \
        vte-profile \
        libadwaita && \
    rpm-ostree install \
        ptyxis && \
    rm -f /etc/yum.repos.d/_copr_kylegospo*
 fi

# packages
sh /tmp/packages.sh

