FROM frolvlad/alpine-glibc:alpine-3.5_glibc-2.25

RUN mkdir /tmp/install-tl-unx

WORKDIR /tmp/install-tl-unx

COPY texlive.profile .

# Install TeX Live 20xx with some basic collections
# we need to install perl, wget, xz and tar as dependencies for the building process
RUN apk --no-cache add perl wget xz tar && \
	wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
	tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
	./install-tl --profile=texlive.profile
RUN apk del perl wget xz tar
RUN cd && rm -rf /tmp/install-tl-unx

RUN mkdir /workdir

ENV PATH="/usr/local/texlive/20xx/bin/x86_64-linux:${PATH}"

WORKDIR /workdir

COPY test.tex .

VOLUME ["/workdir"]
