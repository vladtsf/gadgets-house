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