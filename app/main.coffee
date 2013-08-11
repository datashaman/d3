require('zappajs') ->
    @include 'config'
    @include 'line'
    @include 'map'

    @view index: ->
        ul id: 'links', ->
            li -> a href: '/line', -> 'Line Graph'
            li -> a href: '/map', -> 'Map'

    @get '/', ->
        @render index:
            title: 'Index'
