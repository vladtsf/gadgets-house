(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Witness.views.Users = (function(_super) {

    __extends(Users, _super);

    function Users() {
      return Users.__super__.constructor.apply(this, arguments);
    }

    Users.prototype.initialize = function() {};

    Users.prototype.render = function() {
      Witness.View.prototype.render.call(this);
      this.$usersRoot = this.$el.find(".b-users-table__body");
      return this;
    };

    Users.prototype.template = "users";

    return Users;

  })(Witness.View);

}).call(this);
