(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Witness.models.Users = (function(_super) {

    __extends(Users, _super);

    function Users() {
      return Users.__super__.constructor.apply(this, arguments);
    }

    Users.prototype.initialize = function(users) {
      this.on("remove", function(model, collection) {
        model.view.remove();
        return model.destroy();
      });
      return this.on("add", function(model, collection) {
        return model.view.render();
      });
    };

    Users.prototype.destroy = function() {
      var _ref;
      this.remove(this.models);
      return (_ref = this.view) != null ? _ref.remove() : void 0;
    };

    Users.prototype.render = function() {
      var model, _i, _len, _ref, _results;
      this.view = new Witness.views.Users();
      this.view.render();
      this.pager = new Witness.views.UsersPager();
      this.pager.setElement(this.view.$el.find(".b-users__pagination"));
      this.pager.render({
        offset: this.offset,
        count: this.count
      });
      _ref = this.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        _results.push(this.view.$usersRoot.append(model.view.el));
      }
      return _results;
    };

    Users.prototype.parse = function(res) {
      this.offset = res.offset;
      this.count = res.count;
      return res.users;
    };

    Users.prototype.url = "/admin/users";

    Users.prototype.model = Witness.models.User;

    return Users;

  })(Backbone.Collection);

}).call(this);
