# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require mustache.min.js
#= require_tree .

# 取GET参数
params = (name) ->
  uri = location.search
  obj = {}
  string_array = []
  string_array = uri.replace('?', '').split('&')
  i = 0
  while i < string_array.length
    obj[string_array[i].split('=')[0]] = string_array[i].split('=')[1] or ''
    i++
  obj[name]

# AJAX加载更多
load_more = ->
  running = false
  ->
    if !running
      disabled = $('#btn-load-more').attr('disabled')
      if !disabled
        running = true
        last_id = $('.event:last').attr('guid')
        $.ajax
          url: '/events/load_more'
          data:
            last_id: last_id
            team_id: params('team_id')
          method: 'get'
          dataType: 'json'
          success: (data) ->
            console.log data
            if data.length > 0
              for i of data
                insert_event data[i]
            else
              $('#btn-load-more').attr 'disabled', true
            return
          complete: ->
            running = false
            return
    return

# 向页面内插入一条动态
insert_event = (obj) ->
  if $('.events-day[data-absdate=' + obj.absdate + ']').length == 0
# insert day
    html = Mustache.render($('#tpl-events-day').text(), obj)
    $('#btn-load-more').before html
  # insert event
  html = $(Mustache.render($('#tpl-events-event').text(), obj))
  if $('.events-ancestor:last').attr('data-ancestor-guid') == html.attr('data-ancestor-guid')
    html.find('.events-ancestor-title').remove()
  $('.events-day[data-absdate=' + obj.absdate + '] .events-day-content').append html
  return

$ ->
# 下拉加载
  if $('#btn-load-more').length > 0
    load = load_more()
    $(window).scroll (e, h) ->
      top = $(window).scrollTop() + $(window).height()
      pos = $('#btn-load-more').offset().top
      if top >= pos
        load()
      return
  return
