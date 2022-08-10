FROM alpine:latest

ARG PYTHON_VERSION=3.9.9
ARG ANSIBLE_VERSION=5.9.0

RUN apk add \
    wget \
    gcc \
    make \
    zlib-dev \
    libffi-dev \
    openssl-dev \
    musl-dev

# build python and install ansible
RUN cd /opt \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xzf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --prefix=/usr --enable-optimizations --with-ensurepip=install \
    && make altinstall \
    && ln -s /usr/bin/python${PYTHON_VERSION:0:3} /usr/bin/python \
    && ln -s /usr/bin/pip${PYTHON_VERSION:0:3} /usr/bin/pip \
    && pip install ansible==${ANSIBLE_VERSION}

# make shell experience a little better
RUN apk add bash git \
    && bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

CMD tail -f /dev/null

