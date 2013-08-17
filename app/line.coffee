@include = ->
    @on realtime: (isOn) ->
        if isOn
            emitDatum = => @emit lineDatum: {val: parseInt(Math.random() * 2000)}
            @app.interval = setInterval(emitDatum, 500)
        else
            clearInterval @app.interval

    @get '/line': ->
        @render line:
            title: 'Line Graph'
            scripts: [
                '/zappa/Zappa.js',

                '/components/rickshaw/vendor/d3.min.js',
                '/components/rickshaw/vendor/d3.layout.min.js',
                '/components/rickshaw/rickshaw.min.js',
                '/components/underscore/underscore-min.js',

                '/components/knockout/build/output/knockout-latest.debug.js',

                '/line.js',
            ]
            stylesheets: [
                '/components/rickshaw/rickshaw.min.css',
                '/line.css',
            ]

    @css '/line.css':
        '#buttons':
            marginBottom: '10px'

        '#graph-container':
            position: 'relative'
            fontFamily: 'Arial, Helvetica, sans-serif'
            height: '500px'

        '#graph':
            position: 'absolute'
            top: 0
            left: '40px'

        '#y-axis':
            position: 'absolute'
            top: 0
            left: 0
            width: '40px'

    @view line: ->
        div id: 'buttons', ->
            input type: 'button', value: 'Resume'
            span id: 'current-datum', 'data-bind': 'text: val'

        div id: 'graph-container', ->
            div id: 'y-axis'
            div id: 'graph'

    @client '/line.js': ->
        ko.extenders.updateSeries = (target, model) ->
            target.subscribe (datum) ->
                model.updateSeries(datum)
            target

        class ViewModel
            constructor: (@graphId, @yAxisId, @datumName) ->
                @val = ko.observable()
                @datum = ko.observable().extend
                    updateSeries: @

                @graph = new Rickshaw.Graph
                    element: document.getElementById(@graphId)
                    width: 900
                    height: 500
                    renderer: 'line'
                    series: new Rickshaw.Series.FixedDuration [{name: @datumName}], undefined,
                        timeInterval: 500,
                        maxDataPoints: 100

                xAxis = new Rickshaw.Graph.Axis.Time
                    graph: @graph

                yAxis = new Rickshaw.Graph.Axis.Y
                    graph: @graph
                    orientation: 'left'
                    tickFormat: Rickshaw.Fixtures.Number.formatKMBT
                    element: document.getElementById(@yAxisId)

                @graph.render()

            updateSeries: (datum) ->
                @graph.series.addData datum
                @graph.render()
                @val(datum.val)

        @connect()

        zappa = @

        @get '#/': =>
            viewModel = new ViewModel('graph', 'y-axis', 'val')
            ko.applyBindings viewModel

            @on lineDatum: ->
                viewModel.datum(@data)

            $ ->
                $('input')
                    .click(->
                        button = $(@)

                        if button.val() == 'Pause'
                            zappa.emit realtime: false
                            button.val('Resume')
                        else
                            zappa.emit realtime: true
                            button.val('Pause'))
                    .trigger('click')
