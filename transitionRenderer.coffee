_ = require 'lodash'
module.exports = (PageProto) ->

  _render = PageProto.render

  PageProto.render = (ns, options) ->
    options ?= {}
    container = @model.get '$render.container'

    unless ns is @model.get('$render.previousNs')
      options.container ?= if container is 'pane-1'
        'pane-2'
      else
        'pane-1'

      back = @model.get('$render.back')
      if back
        @model.set '$render.transition', 'backward'
      else
        @model.set '$render.transition', 'forward'

    @model.del '$render.back'
    @model.set '$render.previousNs', ns
    _render.call this, ns, options
