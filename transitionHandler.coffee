addClass = (elementId, className) ->
  document.getElementById(elementId).classList.add className

removeClass = (elementId, className) ->
  document.getElementById(elementId).classList.remove className


module.exports = (model) ->

  container = model.get('$render.container')
  transition = model.get('$render.transition')

  if container is 'pane-2'

    removeClass 'pane-2-wrapper', 'current-pane'
    addClass 'pane-2-wrapper', 'next-pane'

    removeClass 'pane-1-wrapper', 'next-pane'
    addClass 'pane-1-wrapper', 'current-pane'

    document.getElementById('transition-panes').dataset.transition =
      transition || 'forward'
    addClass 'transition-panes', 'transition-2'
    removeClass 'transition-panes', 'transition-1'

  else if container is 'pane-1'

    removeClass 'pane-1-wrapper', 'current-pane'
    addClass 'pane-1-wrapper', 'next-pane'

    removeClass 'pane-2-wrapper', 'next-pane'
    addClass 'pane-2-wrapper', 'current-pane'

    document.getElementById('transition-panes').dataset.transition =
      transition || 'forward'
    addClass 'transition-panes', 'transition-1'
    removeClass 'transition-panes', 'transition-2'
