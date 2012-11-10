jade.templates = jade.templates || {};
jade.templates['user'] = (function(){
  return function anonymous(locals, attrs, escape, rethrow, merge) {
attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
var buf = [];
with (locals || {}) {
var interp;
var roles = ({1: "Администратор"});
buf.push('<td><a');
buf.push(attrs({ 'href':("#users/" + ( _id ) + "") }, {"href":true}));
buf.push('><i class="icon-user"></i>&nbsp;');
var __val__ = _id
buf.push(escape(null == __val__ ? "" : __val__));
buf.push('</a></td><td>');
var __val__ = email
buf.push(escape(null == __val__ ? "" : __val__));
buf.push('</td><td><span class="label label-important">Пользователь</span>');
// iterate roles
;(function(){
  if ('number' == typeof roles.length) {

    for (var $index = 0, $$l = roles.length; $index < $$l; $index++) {
      var role = roles[$index];

if ( roles[ role ])
{
buf.push('&nbsp;<span class="label label-important">');
var __val__ = roles[ role ]
buf.push(escape(null == __val__ ? "" : __val__));
buf.push('</span>');
}
    }

  } else {
    var $$l = 0;
    for (var $index in roles) {
      $$l++;      var role = roles[$index];

if ( roles[ role ])
{
buf.push('&nbsp;<span class="label label-important">');
var __val__ = roles[ role ]
buf.push(escape(null == __val__ ? "" : __val__));
buf.push('</span>');
}
    }

  }
}).call(this);

buf.push('</td>');
}
return buf.join("");
};
})();
jade.templates = jade.templates || {};
jade.templates['users-pager'] = (function(){
  return function anonymous(locals, attrs, escape, rethrow, merge) {
attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
var buf = [];
with (locals || {}) {
var interp;
buf.push('<ul class="pager b-users-pager">');
var page = (~~(offset / 10));
var previousDisabled = (offset === 0);
var nextDisabled = (count - offset < 10);
buf.push('<li');
buf.push(attrs({ "class": ('previous') + ' ' + (previousDisabled ? "disabled" : "") }, {"class":true}));
buf.push('><a');
buf.push(attrs({ 'href':(page > 0 ? "#users/page/" + ( previousDisabled ? page : page - 1 ) + "" : "#users") }, {"href":true}));
buf.push('>&larr; Prev</a></li><li');
buf.push(attrs({ "class": ('next') + ' ' + (nextDisabled ? "disabled" : "") }, {"class":true}));
buf.push('><a');
buf.push(attrs({ 'href':("#users/page/" + ( nextDisabled ? page : page + 1 ) + "") }, {"href":true}));
buf.push('>Next &rarr;</a></li></ul>');
}
return buf.join("");
};
})();
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