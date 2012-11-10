jade.templates = jade.templates || {};
jade.templates['users'] = (function(){
  return function anonymous(locals, attrs, escape, rethrow, merge) {
attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
var buf = [];
with (locals || {}) {
var interp;
buf.push('<div class="container b-users"><h1>Пользователи</h1><div class="row b-users__list"><table class="table table-bordered table-striped b-users-table"><thead><tr><th>id</th><th>email</th><th>роли</th></tr></thead><tbody class="b-users-table__body"></tbody></table></div><div class="row b-users__pagination"></div></div>');
}
return buf.join("");
};
})();