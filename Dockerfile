FROM debian:12.7

SHELL ["bash", "-euxo", "pipefail", "-c"]

RUN set -euxo pipefail >/dev/null \
&& export DEBIAN_FRONTEND=noninteractive \
&& apt-get update -qq --yes \
&& apt-get install -qq --no-install-recommends --yes \
  bash \
  ca-certificates \
  curl \
  git \
  make \
  sudo \
  tar \
  xz-utils \
>/dev/null \
&& rm -rf /var/lib/apt/lists/* \
&& apt-get clean autoclean >/dev/null \
&& apt-get autoremove --yes >/dev/null


ENV TRIPLET="x86_64-w64-mingw32"
ENV GCC_DIR="/opt/gcc"
RUN set -euxo pipefail >/dev/null \
&& mkdir -p "${GCC_DIR}" \
&& curl -fsSL "https://github.com/binarylandia/build_crosstool-ng/releases/download/2024-11-02_10-18-46/gcc-14.2.0-${TRIPLET}-2024-11-02_10-18-46.tar.xz" | tar -C "${GCC_DIR}" -xJ \
&& ls ${GCC_DIR}/bin/${TRIPLET}-gcc \
&& ${GCC_DIR}/bin/${TRIPLET}-gcc -v \
&& ls ${GCC_DIR}/bin/${TRIPLET}-gcc-ar \
&& ${GCC_DIR}/bin/${TRIPLET}-gcc-ar --version


ENV CC="${GCC_DIR}/bin/${TRIPLET}-cc"
ENV CXX="${GCC_DIR}/bin/${TRIPLET}-g++"
ENV FC="${GCC_DIR}/bin/${TRIPLET}-gfortran"
ENV ADDR2LINE="${GCC_DIR}/bin/${TRIPLET}-addr2line"
ENV AR="${GCC_DIR}/bin/${TRIPLET}-gcc-ar"
ENV AS="${GCC_DIR}/bin/${TRIPLET}-as"
ENV CPP="${GCC_DIR}/bin/${TRIPLET}-cpp"
ENV ELFEDIT="${GCC_DIR}/bin/${TRIPLET}-elfedit"
ENV LD="${GCC_DIR}/bin/${TRIPLET}-ld"
ENV LDD="${GCC_DIR}/bin/${TRIPLET}-ldd"
ENV NM="${GCC_DIR}/bin/${TRIPLET}-gcc-nm"
ENV OBJCOPY="${GCC_DIR}/bin/${TRIPLET}-objcopy"
ENV OBJDUMP="${GCC_DIR}/bin/${TRIPLET}-objdump"
ENV RANLIB="${GCC_DIR}/bin/${TRIPLET}-gcc-ranlib"
ENV READELF="${GCC_DIR}/bin/${TRIPLET}-readelf"
ENV SIZE="${GCC_DIR}/bin/${TRIPLET}-size"
ENV STRINGS="${GCC_DIR}/bin/${TRIPLET}-strings"
ENV STRIP="${GCC_DIR}/bin/${TRIPLET}-strip"


ARG USER=user
ARG GROUP=user
ARG UID
ARG GID

ENV USER=$USER
ENV GROUP=$GROUP
ENV UID=$UID
ENV GID=$GID
ENV TERM="xterm-256color"
ENV HOME="/home/${USER}"

COPY docker/files /

RUN set -euxo pipefail >/dev/null \
&& /create-user \
&& sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' \
&& sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' \
&& sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' \
&& echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
&& touch ${HOME}/.hushlogin \
&& chown -R ${UID}:${GID} "${HOME}"

USER ${USER}
