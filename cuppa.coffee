require('zappajs') ->
    @use 'partials', 'bodyParser', 'methodOverride', 'static', 'cookieParser'

    RedisStore = require('connect-redis')(@express)
    @use session:
        store: new RedisStore()
        secret: 'yap7Neek1aidee3Deexiena1eefughoh'

    @use @app.router

    @enable 'default layout'

    @view page: ->
        div id: 'content'

    @postrender
        appendLog: ($) ->
            $('body').append('<div id="log" />')

    @get '/': ->
        @render page:
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

    @on realtime: (isOn) ->
        if isOn
            emitData = => @emit data: {val: parseInt(Math.random() * 2000)}
            @app.interval = setInterval(emitData, 500)
        else
            clearInterval @app.interval

    @client '/index.js': ->
        graph = null
        zappa = @

        @connect()

        (->
            # @use 'Meld'
            @use 'Title'

            @setTitle 'Sample App -'
            @element_selector = '#content'

            @get '#/line', ->
                @title 'Line graph'
                @partial 'line.html', ->
                    graph = new Rickshaw.Graph
                        element: document.getElementById('chart')
                        width: 900
                        height: 500
                        renderer: 'line'
                        series: new Rickshaw.Series.FixedDuration([{name: 'val'}], undefined, {
                            timeInterval: 500,
                            maxDataPoints: 100
                        })

                    xAxis = new Rickshaw.Graph.Axis.Time
                        graph: graph

                    yAxis = new Rickshaw.Graph.Axis.Y
                        graph: graph
                        orientation: 'left'
                        tickFormat: Rickshaw.Fixtures.Number.formatKMBT
                        element: document.getElementById('y-axis')

                    graph.render()

                    $('input')
                        .click(->
                            button = $(@)

                            if button.val() == 'Pause'
                                zappa.emit realtime: false
                                button.val('Resume')
                            else
                                zappa.emit realtime: true
                                button.val('Pause'))
                        .click()

        ).call @app

        @on
            data: ->
                graph.series.addData @data
                graph.render()
