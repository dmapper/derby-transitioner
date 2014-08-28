transitionHandler = require './transitionHandler'
PageOverride = require './Page'
PageTransitionRenderer = require './transitionRenderer'


module.exports = (app, options) ->

  app.loadViews __dirname unless options?.customViews

  app.loadStyles __dirname unless options?.customStyles

  app.proto.tBack = ->
    @model.set '$render.back', true

  app.on 'ready', ->

    @model.set '$render.previousNs', @model.get('$render.ns')

    # Simple check for Back button click
    # Major downside is that it fires for any History switch
    # TODO: Save URL's to sessionStore and check if N-2 url is the same
    window.addEventListener 'popstate', =>
      @model.set '$render.back', true

    PageProto = Object.getPrototypeOf(app.page)
    PageOverride PageProto
    PageTransitionRenderer PageProto

    # Transition panes when derby finished rendering
    app.on 'routeDone', =>
      setTimeout =>
        transitionHandler @model
      , 100