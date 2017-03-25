#!/bin/bash

pkgs=$(go list ./... 2> /dev/null | grep -v /vendor/)
echo "mode: atomic" > profile.cov

for pkg in $pkgs; do
    set -e
    go test -v -race -cover -coverprofile=profile.tmp $pkg
    set +e

    if [ -f profile.tmp ]; then
        tail -n +2 profile.tmp >> profile.cov
        rm profile.tmp
    fi
done;

go tool cover -func=profile.cov
