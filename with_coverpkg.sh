#!/bin/bash

pkgs=$(go list ./... 2> /dev/null | grep -v /vendor/)
deps=`echo ${pkgs} | tr ' ' ","`
echo "mode: atomic" > profile.cov

for pkg in $pkgs; do
    set -e
    go test -v -race -cover -coverpkg "$deps" -coverprofile=profile.tmp $pkg
    set +e

    if [ -f profile.tmp ]; then
        tail -n +2 profile.tmp >> profile.cov
        rm profile.tmp
    fi
done;

go tool cover -func=profile.cov
