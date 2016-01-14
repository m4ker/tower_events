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

function load_more() {
    var running = false;
    return function () {
        if (!running) {
            running = true;
            // todo: $.ajax();
            alert('hey!')
        }
    }
}