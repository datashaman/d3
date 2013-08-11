@include = ->
    @view map: ->
        div id: 'map'

    @css '/map.css':
        '#map':
            height: '500px'

    @coffee '/map.js': ->
        apiKey = '46d8b39e9b6f4ab5a6118e74cf1da50d'

        $ ->
            map = L.map('map').setView([51.505, -0.09], 13)

            L.tileLayer('http://{s}.tile.cloudmade.com/' + apiKey + '/997/256/{z}/{x}/{y}.png',
                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
                maxZoom: 18
            ).addTo(map)

    @get '/map': ->
        @render map:
            title: 'Map'
            scripts: [
                '/zappa/Zappa.js',
                '/components/leaflet/dist/leaflet.js',
                '/map.js',
            ]
            stylesheets: [
                '/components/leaflet/dist/leaflet.css',
                '/map.css',
            ]
