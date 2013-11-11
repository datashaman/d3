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
        if @stylesheets
            for media, urls of @stylesheets
                if not stylesheets.media?
                    stylesheets.media = []
                stylesheets.media.concat(urls)

        extension = (path,ext) ->
            if path.substr(-(ext.length)).toLowerCase() is ext.toLowerCase()
                path
            else
                path + ext
        doctype 5
        html ->
            head ->
                title @title if @title

                for media, urls of stylesheets
                    for url in urls
                        if typeof url == 'string'
                            link rel: 'stylesheet', href: extension url, '.css', media
                        else
                            [ url, condition ] = url
                            ie condition, ->
                                link rel: 'stylesheet', href: extension url, '.css', media

                style @style if @style

            body ->
                div id: 'root', ->
                    header ->
                        nav ->
                            ul -> for url, title of @settings.navigation
                                li -> a href: url + '#/', -> title

                    section ->
                        header ->
                        article @body
                        footer ->

                    footer id: 'root_footer'

                footer id: 'footer', 'footer'

                for s in scripts
                    script src: extension s, '.js'

    @view index: ->
        div id: 'index'

    @get '/', ->
        @render index:
            title: 'Experiments'

    @client '/scripts/site.js': ->
