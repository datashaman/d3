lorem = require 'lorem'

@include = ->
    @locals.navigation['/map'] = 'Map'

    @on generateMap: (enabled) ->
        if enabled
            emitValue = =>
                lat = 51.505 + (Math.random() * 0.5) - 0.25
                lng = -0.09 + (Math.random() * 0.5) - 0.25
                @emit map:
                    lat: lat
                    lng: lng
                    info: lorem.ipsum('p')
            @interval = setInterval(emitValue, 500)
        else
            clearInterval @interval

    @get '/map': ->
        @render map:
            title: 'Map'
            scripts: [
                '/zappa/Zappa.js'
                '/components/leaflet/dist/leaflet.js'
                '/components/knockout/build/output/knockout-latest.debug.js'
                '/components/underscore/underscore-min.js'
                '/map.js'
            ]
            stylesheets: [
                '/components/leaflet/dist/leaflet.css'
                '/map.css'
            ]

    @css '/map.css':
        '#map':
            height: '500px'

    @view map: ->
        div id: 'map'

    @client '/map.js': ->
        viewModel = null

        class ViewModel
            constructor: (@mapId, @apiKey) ->
                @data = ko.observableArray([])

                @data.subscribe (data) =>
                    @addMarker(data)

                @map = L.map(@mapId).setView([51.505, -0.09], 10)

                L.tileLayer('http://{s}.tile.cloudmade.com/' + @apiKey + '/997/256/{z}/{x}/{y}.png',
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>'
                    maxZoom: 18
                ).addTo(@map)

            addMarker: (data) ->
                datum = _(data).last()
                L.marker([datum.lat, datum.lng])
                    .addTo(@map)
                    .bindPopup(datum.info)

        @connect()

        @on map: ->
            viewModel.data.push(@data)

        @get '#/': =>
            viewModel = new ViewModel('map', '46d8b39e9b6f4ab5a6118e74cf1da50d')
            ko.applyBindings viewModel
            @emit generateMap: true
