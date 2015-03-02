window.$ = window.jQuery = require 'jquery'
require 'bootstrap'

$ ->
  window.smoothScroll.init()
  initAnalytics()
  bindSendMessage()

initAnalytics = ->
  track('#headerwrap .cta a', 'Top hero CTA')
  track('.nav a', 'Navbar')
  track('.nav a.btn-primary', 'Navbar CTA')
  track('.carousel-indicators li', 'Carousel')
  track('#pricing cta', 'Bottom CTA')
  track('#drop-a-line', 'Drop a line')
  track('#send-message', 'Send message')

track = (selector, msg) ->
  $(selector).on 'click', (e) ->
    analytics.track msg,
      text: $(e.target).text()

bindSendMessage = ->
  $('#send-message').on 'click', (e) ->
    e.preventDefault()

    $.ajax(
      url: '//formspree.io/domas.bitvinskas@me.com'
      method: 'POST'
      data:
        email: $('#your-email').val()
        message: $('#your-message').val()
      dataType: 'json'
    ).then (err, resp) ->
      $('#drop-a-line').addClass('hidden')

      if resp == 'success'
        $('#thanks-note').removeClass('hidden')
      else
        $('#error-note').removeClass('hidden')
