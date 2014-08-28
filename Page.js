// Add support for rendering into element with specified #id

module.exports = function(PageProto) {

  PageProto.render = function(ns, options) {
    options || (options = {});
    this.app.emit('render', this);
    this.context.pause();
    this._setRenderParams(ns);
    this._setContainerRenderParams(ns, options);
    var titleFragment = this.getFragment('TitleElement', ns);
    var titleElement = document.getElementsByTagName('title')[0];
    titleElement.parentNode.replaceChild(titleFragment, titleElement);
    if (options.container) {
      this._renderContainer(ns, options.container);
    } else {
      this._renderBody(ns)
    }
    this.context.unpause();
    this.app.emit('routeDone', this, 'render');
  };

  PageProto._setContainerRenderParams = function(ns, options) {
    options || (options = {});
    this.model.set('$render.container', options.container);
  };

  PageProto._renderBody = function(ns) {
    var bodyFragment = this.getFragment('BodyElement', ns);
    document.body.parentNode.replaceChild(bodyFragment, document.body);
  };

  PageProto._renderContainer = function(ns, containerId) {
    var containerFragment = this.getFragment('ContainerElement', ns);
    var containerElement = document.getElementById(containerId);
    containerElement.parentNode.replaceChild(containerFragment, containerElement);
  };

};