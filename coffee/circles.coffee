@include = ->
    @settings.navigation['/circles'] = 'Circles'

    @get '/circles': ->
        @render circles:
            title: 'Circles'
            scripts: [
                '/components/d3/d3.js'
                '/circles.js'
            ]
            stylesheets: {
                'screen, projector': [
                    '/circles.css'
                ]
            }

    @css '/circles.css': ->

    @view circles: ->

    @client '/circles.js': ->
        w = 500
        h = 50

        svg = d3.select('article')
            .append('svg')
            .attr('width', w)
            .attr('height', h)

        dataset = [ 5, 10, 15, 20, 25]

        circles = svg.selectAll('circle')
            .data(dataset)
            .enter()
            .append('circle')

        circles.attr
            cx: (d, i) -> i * 50 + 25
            cy: -> h/2
            r: (d) -> d
            fill: 'yellow'
            stroke: 'orange'
            'stroke-width': (d) -> d/2
