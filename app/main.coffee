require('zappajs') ->
    @include 'config'
    @include 'line'
    @include 'map'
    @include 'd3'

    @view index: ->
        ul id: 'links', ->
            li -> a href: '/line', -> 'Line Graph'
            li -> a href: '/map', -> 'Map'
            li -> a href: '/d3', -> 'D3'

    @get '/', ->
        @render index:
            title: 'Index'
