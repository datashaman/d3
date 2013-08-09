require('zappajs') ->
    @use 'partials', 'bodyParser', 'methodOverride', 'static', 'cookieParser'

    RedisStore = require('connect-redis')(@express)
    @use session:
        store: new RedisStore()
        secret: 'yap7Neek1aidee3Deexiena1eefughoh'

    @use @app.router

    @enable 'default layout'

    @view index: ->
        div id: 'content'

    @postrender
        appendLog: ($) ->
            $('body').append('<div id="log" />')

    @get '/': ->
        @render index:
            title: 'Index'
            scripts: [
                '/zappa/Zappa.js',
                '/components/sammy/lib/plugins/sammy.flash.js',
                '/components/sammy/lib/plugins/sammy.form.js',
                '/components/sammy/lib/plugins/sammy.json.js',
                '/components/sammy/lib/plugins/sammy.meld.js',
                '/components/sammy/lib/plugins/sammy.storage.js',
                '/components/sammy/lib/plugins/sammy.title.js',
                '/index.js',
            ]
            postrender: 'appendLog'

    @on
        connection: ->
            emitData = => @emit data:
                x: new Date().getTime()
                y: Math.random() * 2000
            setInterval emitData, 10000

    @client '/index.js': ->
        @connect()

        @app.use 'Meld'
        @app.use 'Title'

        @app.setTitle 'Sample App -'
        @app.element_selector = '#content'

        @app.get '#/line', ->
            @title 'Line graph'
            @partial 'line.html', =>
                @meld $('.data'),
                    data: 'blah'

        @on
            data: ->
                thing = $('#log').html "X: #{@data.x}; Y: #{@data.y}"
                thing.focus()
