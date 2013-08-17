## Execute in bash

### [nodejs](http://nodejs.org/) and [npm](http://npmjs.org/)
    # pushd /tmp
    # wget http://nodejs.org/dist/v0.10.16/node-v0.10.16.tar.gz &&
    # tar xzf node-v0.10.16.tar.gz &&
    # cd node-v0.10.16/ &&
    # ./configure &&
    # make &&
    # sudo make install
    # popd

### [nodemon](http://remy.github.io/nodemon/)
    # sudo npm install -g nodemon

### [bower](http://bower.io/)
    # sudo npm install -g bower

### [jake](https://npmjs.org/package/jake)
    # sudo npm install -g jake

### server dependencies
    npm install

### client dependencies
    bower install

### [knockout](http://knockoutjs.com/)
    pushd bower_components/knockout
    build/build.sh
    popd

### [leaflet](http://leafletjs.com/)
    pushd bower_components/leaflet
    npm install jshint
    npm install uglify-js
    jake

### start server
    nodemon

### open browser
    sensible-browser http://localhost:3000/
