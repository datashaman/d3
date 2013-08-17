require('zappajs') ->
    @include 'config'

    @include 'line'
    @include 'map'
    @include 'bar'
    @include 'circles'
    @include 'svg'

    @view index: ->
        ul id: 'links', ->
            li -> a href: '/line', -> 'Realtime Line Graph'
            li -> a href: '/map', -> 'Map'
            li -> a href: '/bar', -> 'Bar Graph'
            li -> a href: '/circles', -> 'Circles'
            li -> a href: '/svg', -> 'SVG'

    @get '/', ->
        @render index:
            title: 'Experiments'
