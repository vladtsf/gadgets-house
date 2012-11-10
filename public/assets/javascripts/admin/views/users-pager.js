(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Witness.views.UsersPager = (function(_super) {

    __extends(UsersPager, _super);

    function UsersPager() {
      return UsersPager.__super__.constructor.apply(this, arguments);
    }

    UsersPager.prototype.initialize = function() {};

    UsersPager.prototype.template = "users-pager";

    UsersPager.prototype.options = {
      el: "#layout"
    };

    return UsersPager;

  })(Witness.View);

}).call(this);
