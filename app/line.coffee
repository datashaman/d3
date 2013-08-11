@include = ->
    @on realtime: (isOn) ->
        if isOn
            emitData = => @emit data: {val: parseInt(Math.random() * 2000)}
            @app.interval = setInterval(emitData, 500)
        else
            clearInterval @app.interval

    @view line: ->
        div id: 'chart-container', ->
            div id: 'y-axis'
            div id: 'chart'
        div id: 'buttons', ->
            input type: 'button', value: 'Resume'

    @css '/line.css':
        '#chart-container':
            position: 'relative'
            fontFamily: 'Arial, Helvetica, sans-serif'

        '#chart':
            position: 'relative'
            left: '40px'

        '#y-axis':
            position: 'absolute'
            top: 0
            bottom: 0
            width: '40px'

    @client '/line.js': ->
        graph = null
        zappa = @

        @connect()

        @on data: ->
            graph.series.addData @data
            graph.render()

        @get '#/': ->
            $ =>
                graph = new Rickshaw.Graph
                    element: document.getElementById('chart')
                    width: 900
                    height: 500
                    renderer: 'line'
                    series: new Rickshaw.Series.FixedDuration([{name: 'val'}], undefined, {
                        timeInterval: 500,
                        maxDataPoints: 100
                    })
                graph.render()

                xAxis = new Rickshaw.Graph.Axis.Time
                    graph: graph
                xAxis.render()

                yAxis = new Rickshaw.Graph.Axis.Y
                    graph: graph
                    orientation: 'left'
                    tickFormat: Rickshaw.Fixtures.Number.formatKMBT
                    element: document.getElementById('y-axis')
                yAxis.render()

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

    @get '/line': ->
        @render line:
            title: 'Line Graph'
            scripts: [
                '/zappa/Zappa.js',

                '/components/rickshaw/vendor/d3.min.js',
                '/components/rickshaw/vendor/d3.layout.min.js',
                '/components/rickshaw/rickshaw.min.js',
                '/components/underscore/underscore-min.js',

                '/line.js',
            ]
            stylesheets: [
                '/components/rickshaw/rickshaw.min.css',
                '/line.css',
            ]
