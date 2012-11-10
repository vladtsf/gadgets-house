(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Witness.View = (function(_super) {

    __extends(View, _super);

    function View() {
      return View.__super__.constructor.apply(this, arguments);
    }

    View.prototype.initialize = function() {};

    View.prototype.getTemplate = function() {
      return jade.templates[this.template];
    };

    View.prototype.render = function(params) {
      var _base, _ref;
      this.$el.html(typeof (_base = this.getTemplate()) === "function" ? _base(_.extend({}, params, (_ref = this.model) != null ? _ref.toJSON() : void 0)) : void 0);
      return this;
    };

    return View;

  })(Backbone.View);

}).call(this);
