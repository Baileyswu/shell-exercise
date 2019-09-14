#! /bin/sh

echo $GOPATH
TEST=$GOPATH/src/local/test
mkdir -p $TEST
cd $GOPATH/src/goms.io/aks/rp
pwd
cp -rf * $TEST/