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