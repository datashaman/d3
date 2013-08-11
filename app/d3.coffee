@include = ->
    @view d3: ->
        div id: 'd3'

    @css '/d3.css':
        '#d3':
            height: '500px'

    @client '/d3.js': ->
        @get '#/': ->
            console.log 'here'

    @get '/d3': ->
        @render d3:
            title: 'D3'
            scripts: [
                '/zappa/Zappa.js',
                '/components/d3/d3.js',
                '/d3.js',
            ]
            stylesheets: [
                '/d3.css',
            ]
