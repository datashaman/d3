redis = require 'connect-redis'

@include = ->
    @use 'partials', 'bodyParser', 'methodOverride', 'static', 'cookieParser'

    RedisStore = redis(@express)
    @use session:
        store: new RedisStore()
        secret: 'yap7Neek1aidee3Deexiena1eefughoh'

    @use @app.router

    @enable 'default layout'

    @io.configure 'production', ->
        @enable('browser client minification')
        @enable('browser client etag')          # apply etag caching logic based on version number
        @enable('browser client gzip')          # gzip the file
        @set('log level', 1)                    # warn

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
