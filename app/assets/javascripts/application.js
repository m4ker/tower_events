// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){
    if ($('#btn-load-more').length > 0) {
        var load = load_more();
        $(window).scroll(function(e, h){
            var top = $(window).scrollTop() + $(window).height();
            var pos = $('#btn-load-more').offset().top;

            if (top >= pos) {
                load();
            }
        });
    }
});

function params(name){
    var uri = location.search;
    var obj = {};
    var string_array = [];
    var string_array = uri.replace('?','').split("&");
    for(var i =0;i<string_array.length; i++){
        obj[ string_array[i].split('=')[0] ] = string_array[i].split('=')[1] || '';
    }
    return obj[name];
}

var tplEngine = function(tpl, data) {
    var reg = /<%([^%>]+)?%>/g,
        regOut = /(^( )?(if|for|else|switch|case|break|{|}))(.*)?/g,
        code = 'var r=[];\n',
        cursor = 0;

    var add = function(line, js) {
        js? (code += line.match(regOut) ? line + '\n' : 'r.push(' + line + ');\n') :
            (code += line != '' ? 'r.push("' + line.replace(/"/g, '\\"') + '");\n' : '');
        return add;
    }
    while(match = reg.exec(tpl)) {
        add(tpl.slice(cursor, match.index))(match[1], true);
        cursor = match.index + match[0].length;
    }
    add(tpl.substr(cursor, tpl.length - cursor));
    code += 'return r.join("");';
    return new Function(code.replace(/[\r\t\n]/g, '')).apply(data);
};

function load_more() {
    var running = false;
    return function () {
        if (!running) {
            running = true;
            var last_id = $('.event:last').attr('guid');
            $.ajax({
                url : '/events/load_more',
                data : {
                    last_id : last_id,
                    team_id : params('team_id')
                },
                method : 'get',
                dataType : 'json',
                success : function (data) {
                    console.log(data)

                },
                complete : function () {
                    running = false;
                }
            });
        }
    }
}