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

### [nodemon](http://remy.github.io/nodemon/)
    sudo npm install -g nodemon

### [bower](http://bower.io/)
    sudo npm install -g bower

### server dependencies
    npm install

### client dependencies
    bower install
