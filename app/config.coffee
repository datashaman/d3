redis = require 'connect-redis'

@include = ->
    @set
        scripts: [
            '/zappa/Zappa.js'
            '//code.jquery.com/ui/1.10.3/jquery-ui.min.js'
            '//cdnjs.cloudflare.com/ajax/libs/knockout/3.0.0/knockout-min.js'
        ]
        stylesheets: [
            '//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css'
        ]


    @use 'partials', 'bodyParser', 'methodOverride', 'static', 'cookieParser'

    RedisStore = redis(@express)
    @use session:
        store: new RedisStore()
        secret: 'yap7Neek1aidee3Deexiena1eefughoh'

    @use @app.router

    @io.configure 'production', ->
        @enable('browser client minification')
        @enable('browser client etag')          # apply etag caching logic based on version number
        @enable('browser client gzip')          # gzip the file
        @set('log level', 2)                    # warn

        # enable all transports (optional if you want flashsocket support, please note that some hosting
        # providers do not allow you to create servers that listen on a port different than 80 or their
        # default port)
        @set('transports', [
            'websocket',
            'flashsocket',
            'htmlfile',
            'xhr-polling',
            'jsonp-polling'
        ])
