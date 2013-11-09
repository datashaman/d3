require('zappajs') {
    io: {
        # 'force new connection': true
        }
}, ->
    @include 'config'

    @set navigation: []

    @include 'map'
    @include 'line'
    @include 'bar'
    @include 'circles'
    @include 'svg'

    @view layout: ->
        scripts = @settings.scripts
        scripts = scripts.concat(@scripts) if @scripts

        stylesheets = @settings.stylesheets
        stylesheets = stylesheets.concat(@stylesheets) if @stylesheets

        extension = (path,ext) ->
            if path.substr(-(ext.length)).toLowerCase() is ext.toLowerCase()
                path
            else
                path + ext
        doctype 5
        html ->
            head ->
                title @title if @title

                for s in stylesheets
                    link rel: 'stylesheet', href: extension s, '.css'

                style @style if @style
            body ->
                header ->
                    nav ->
                        ul -> for url, title of @settings.navigation
                            li -> a href: url + '#/', -> title

                section ->
                    article @body

                for s in scripts
                    script src: extension s, '.js'

    @view index: ->
        div id: 'index'

    @get '/', ->
        @render index:
            title: 'Experiments'
