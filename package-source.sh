#!/bin/sh
cd "$(dirname $0)"
D="$(pwd)"
if [ -z "$VERSION" ]; then
	VERSION=$(grep ^Version: *.spec |cut -d: -f2 |xargs echo)
fi
[ -e v${VERSION}.tar.gz ] && wget https://github.com/zaquestion/lab/archive/refs/tags/v${VERSION}.tar.gz
if ! [ -e godeps-for-lab-${VERSION}.tar.zst ]; then
	rm -rf lab-${VERSION}
	tar xf v${VERSION}.tar.gz
	cd lab-${VERSION}
	export GOPATH=/tmp/godeps.$$/.godeps
	go mod download
	cd /tmp/godeps.$$
	find . -type d |xargs chmod 0755
	find . -type f |xargs chmod 0644
	tar cf ${D}/godeps-for-lab-${VERSION}.tar .godeps
	zstd -22 --ultra ${D}/godeps-for-lab-${VERSION}.tar
	cd ${D}
	rm -rf /tmp/godeps.$$
fi
