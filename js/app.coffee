window.$ = window.jQuery = require 'jquery'
require 'bootstrap'

$ ->
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
