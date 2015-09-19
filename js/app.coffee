window.$ = window.jQuery = require 'jquery'
cookies = require 'browser-cookies'
require 'bootstrap'

$ ->
  personalizeCta()
  $('.btn').addClass('waves-effect waves-light')
  window.smoothScroll.init()
  initAnalytics()
  bindSendMessage()
  initReferrer()
  makeBlogLinksTargetBlank()

personalizeCta = ->
  sign_up_btn = $('.sign-up-btn')
  return unless sign_up_btn.length

  new_btn = switch
    when document.referrer.match(/materialize/)
      text: 'Create free website with Materialize'
      href: 'http://app.closeheat.com/apps/template?github=closeheat/template-materializecss'
    when document.referrer.match(/react/)
      text: 'Create free website with React'
      href: 'http://app.closeheat.com/apps/template?github=closeheat/template-reactjs'

  return unless new_btn
  sign_up_btn.html(new_btn.text).prop('href', new_btn.href)

makeBlogLinksTargetBlank = ->
  $('.blog a').not('.blog .posts-list a').prop('target', '_blank')

initReferrer = ->
  return if cookies.get('ch_initial_referrer')

  cookies.set('ch_initial_referrer', document.referrer, domain: '.closeheat.com')

initAnalytics = ->
  track('.top-hero-cta', 'Hero CTA')
  track('.screenshot', 'Screenshot CTA')
  track('nav .blog', 'Blog')
  track('nav .docs', 'Docs')
  track('nav .team', 'Team')
  track('nav .pricing', 'Pricing')
  track('nav .sign-up', 'Navbar CTA')
  track('.pricing-cta-free', 'Pricing Free CTA')
  track('.pricing-cta-recommended', 'Pricing Recommended CTA')
  track('.pricing-cta-team', 'Pricing Team CTA')

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
      $('#drop-a-line').addClass('hide')

      if resp == 'success'
        $('#thanks-note').removeClass('hide')
      else
        $('#error-note').removeClass('hide')
