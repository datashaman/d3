#!/usr/bin/env bash

### [nodejs](http://nodejs.org/) and [npm](http://npmjs.org/)
    pushd /tmp

    # wget http://nodejs.org/dist/v0.10.16/node-v0.10.16.tar.gz &&
    # tar xzf node-v0.10.16.tar.gz &&
    # cd node-v0.10.16/ &&
    # ./configure &&
    # make &&
    # sudo make install

    popd

### npm dependencies
    npm install

### [bower](http://bower.io/)
    sudo npm install -g bower

### bower dependencies
    bower install
