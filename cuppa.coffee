require('zappajs') ->
    RedisStore = require('connect-redis')(@express)

    @use 'partials', 'bodyParser', 'methodOverride'
    @use cookieParser: {secret: 'AiHeidiek8ahg9heequahme8boxe0ali'}
    @use session: {store: new RedisStore()}, 'static'
    @use @app.router

    @enable 'default layout'

    @get '/': ->
        @render index:
            title: 'Index'
            scripts: [
                '/zappa/Zappa.js',
                '/components/mustache/mustache.js',
                '/components/sammy/lib/plugins/sammy.mustache.js',
                '/index.js',
            ]

    @on connection: ->
        emitData = => @emit data:
            x: new Date().getTime()
            y: Math.random() * 2000

        # setInterval emitData, 3000

    @client '/index.js': ->
        @app.use 'Mustache'
        @app.element_selector = '#content'

        # @connect()

        @get '#/foo': ->
            @test = 'foo'
            @render('someview.mustache', @).swap()

            # @on data: ->
            # thing = $('body').append "X: #{@data.x}; Y: #{@data.y}<br />"
            # thing.focus()

    @view index: ->
        div id: 'content'
