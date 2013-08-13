lorem = require 'lorem'

@include = ->
    @view map: ->
        div id: 'map'

    @css '/map.css':
        '#map':
            height: '500px'

    ###
    @on connection: ->
        emitValue = =>
            lat = 51.505 + (Math.random() * 0.5) - 0.25
            lng = -0.09 + (Math.random() * 0.5) - 0.25
            @emit coords:
                lat: lat
                lng: lng
                info: lorem.ipsum('p')
        setInterval emitValue, 500
    ###

    @client '/map.js': ->
        map = null
        apiKey = '46d8b39e9b6f4ab5a6118e74cf1da50d'

        @connect()

        @on coords: ->
            marker = L.marker([@data.lat, @data.lng]).addTo(map)
            marker.bindPopup(@data.info)

        $ ->
            map = L.map('map').setView([51.505, -0.09], 10)

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
