#!/bin/sh
# Running Parity Full Test Suite

FEATURES="json-tests"
OPTIONS="--release"
VALIDATE=1

case $1 in
  --no-json)
    FEATURES="ipc"
    shift # past argument=value
    ;;
  --no-release)
    OPTIONS=""
    shift
    ;;
  --no-validate)
    VALIDATE=0
    shift
    ;;
  --no-run)
    OPTIONS="--no-run"
    shift
    ;;
  *)
    # unknown option
    ;;
esac

set -e

if [ "$VALIDATE" -eq "1" ]; then
# Validate --no-default-features build
echo "________Validate build________"
cargo check --no-default-features

# Validate chainspecs
echo "________Validate chainspecs________"
./scripts/validate_chainspecs.sh
fi


# Running test's
echo "________Running Parity Full Test Suite________"

cargo test -j 8 $OPTIONS --features "$FEATURES" --all --exclude evmjit $1

