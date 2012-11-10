(function() {
  var AdminApplication,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AdminApplication = (function(_super) {

    __extends(AdminApplication, _super);

    function AdminApplication() {
      return AdminApplication.__super__.constructor.apply(this, arguments);
    }

    AdminApplication.prototype.initialize = function() {};

    AdminApplication.prototype.switchNavBar = function(tab) {
      return $(".b-admin-navbar li:has(a[data-action])").removeClass("active").filter(":has([data-action=\"" + tab + "\"])").addClass("active");
    };

    AdminApplication.prototype.setLayout = function(view) {
      return $("#layout").empty().append(view.el);
    };

    AdminApplication.prototype.dashboard = function() {
      var _ref;
      this.switchNavBar("dashboard");
      return (_ref = this.currentEntity) != null ? _ref.destroy() : void 0;
    };

    AdminApplication.prototype.users = function(page) {
      var oldEntity, users,
        _this = this;
      if (page == null) {
        page = 0;
      }
      this.switchNavBar("users");
      oldEntity = this.currentEntity;
      users = this.currentEntity = new Witness.models.Users();
      return users.fetch({
        add: true,
        data: {
          offset: page * 10
        }
      }).then(function() {
        if (oldEntity != null) {
          oldEntity.destroy();
        }
        users.render();
        return _this.setLayout(users.view);
      });
    };

    AdminApplication.prototype.root = function() {};

    AdminApplication.prototype.routes = {
      "": "dashboard",
      "users": "users",
      "users/page/:page": "users"
    };

    return AdminApplication;

  })(Backbone.Router);

  window.admin = new AdminApplication();

}).call(this);
