@include = ->
    @use 'partials', 'bodyParser', 'methodOverride', 'static', 'cookieParser'

    RedisStore = require('connect-redis')(@express)
    @use session:
        store: new RedisStore()
        secret: 'yap7Neek1aidee3Deexiena1eefughoh'

    @use @app.router

    @enable 'default layout'

