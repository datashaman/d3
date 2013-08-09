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
            scripts: [
                '/zappa/Zappa.js',
                # '/components/sammy/lib/plugins/sammy.flash.js',
                # '/components/sammy/lib/plugins/sammy.form.js',
                # '/components/sammy/lib/plugins/sammy.json.js',
                # '/components/sammy/lib/plugins/sammy.meld.js',
                # '/components/sammy/lib/plugins/sammy.storage.js',
                '/components/sammy/lib/plugins/sammy.title.js',

                '/components/rickshaw/vendor/d3.min.js',
                '/components/rickshaw/vendor/d3.layout.min.js',
                '/components/rickshaw/rickshaw.min.js',
                '/components/underscore/underscore-min.js',

                '/index.js',
            ]
            stylesheets: [
                '/components/rickshaw/rickshaw.min.css',
                '/styles/line.css',
            ]
            postrender: 'appendLog'

    @on
        connection: ->
            emitData = => @emit data:
                units: parseInt(Math.random() * 2000)
            setInterval emitData, 500

    @client '/index.js': ->
        @connect()

        (->

            # @use 'Meld'
            @use 'Title'

            @setTitle 'Sample App -'
            @element_selector = '#content'

            @get '#/line', ->
                @title 'Line graph'
                @partial 'line.html', ->
                    window.graph = new Rickshaw.Graph
                        element: document.getElementById('chart')
                        width: 900
                        height: 500
                        renderer: 'line'
                        series: new Rickshaw.Series.FixedDuration([{name: 'units'}], undefined, {
                            timeInterval: 500,
                            maxDataPoints: 100
                        })
                    window.graph.render()

                    xAxis = new Rickshaw.Graph.Axis.Time
                        graph: window.graph
                    xAxis.render()

                    yAxis = new Rickshaw.Graph.Axis.Y
                        graph: window.graph
                        orientation: 'left'
                        tickFormat: Rickshaw.Fixtures.Number.formatKMBT
                        element: document.getElementById('y-axis')
                    yAxis.render()


        ).call @app

        @on
            data: ->
                console.log @data
                window.graph.series.addData @data
                window.graph.render()
