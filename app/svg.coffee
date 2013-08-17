@include = ->
    @get '/svg': ->
        @render svg:
            title: 'SVG'
            scripts: [
                '/zappa/Zappa.js',
                '/components/d3/d3.js',
                '/svg.js',
            ]
            stylesheets: [
                '/svg.css',
            ]

    @css '/svg.css': ->

    @view svg: ->

    @client '/svg.js': ->
        w = 500
        h = 50

        @get '#/': ->
            svg = d3.select('body')
                .append('svg')
                .attr('width', w)
                .attr('height', h)

            dataset = [ 5, 10, 15, 20, 25]

            circles = svg.selectAll('circle')
                .data(dataset)
                .enter()
                .append('circle')

            circles.attr('cx', (d, i) -> i * 50 + 25)
                .attr('cy', h/2)
                .attr('r', (d) -> d)
                .attr('fill', 'yellow')
                .attr('stroke', 'orange')
                .attr('stroke-width', (d) -> d/2)
