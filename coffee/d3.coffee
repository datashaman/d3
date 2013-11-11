@include = ->
    @get '/d3': ->
        @render d3:
            title: 'D3'
            scripts: [
                '/components/d3/d3.js'
                '/d3.js'
            ]
            stylesheets: {
                'screen, projection': [
                    '/d3.css'
                ]
            }

    @css '/d3.css':
        '.bar':
            display: 'inline-block'
            width: '20px'
            height: '75px'
            backgroundColor: 'teal'
            marginRight: '2px'

    @view d3: ->

    @client '/d3.js': ->
        @get '#/': ->
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
