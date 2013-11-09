require('zappajs') {
    io: {
        # 'force new connection': true
    }
}, ->
    @include 'config'

    @locals.navigation = []

    @include 'map'
    @include 'line'
    @include 'bar'
    @include 'circles'
    @include 'svg'

    @view index: ->
        ul id: 'navigation', ->
            for url, title of @navigation
                li -> a href: url + '#/', -> title

    @get '/', ->
        @render index:
            title: 'Experiments'
