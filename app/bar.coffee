@include = ->
    @settings.navigation['/bar'] = 'Bar Graph'

    @get '/bar': ->
        @render bar:
            title: 'Bar Graph'
            scripts: [
                '/components/d3/d3.js',
                '/bar.js',
            ]
            stylesheets: [
                '/bar.css',
            ]

    @css '/bar.css':
        '.bar':
            display: 'inline-block'
            width: '20px'
            height: '75px'
            backgroundColor: 'teal'
            marginRight: '2px'

    @view bar: ->

    @client '/bar.js': ->
        dataset = [ 25, 7, 5, 26, 11, 8, 25, 14, 23, 19,
                    14, 11, 22, 29, 11, 13, 12, 17, 18, 10,
                    24, 18, 25, 9, 3 ]

        d3.select('body').selectAll('div')
            .data(dataset)
            .enter()
            .append('div')
            .attr('class', 'bar')
            .style('height', (d) ->
                d * 5 + 'px')
