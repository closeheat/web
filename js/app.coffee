window.$ = window.jQuery = require 'jquery'
cookies = require 'browser-cookies'
require 'bootstrap'

$ ->
  # personalizeCta()
  $('.btn').addClass('waves-effect waves-light')
  window.smoothScroll.init()
  initAnalytics()
  bindSendMessage()
  initReferrer()
  makeBlogLinksTargetBlank()
  bindModals()

bindModals = ->
  $(document).on 'click', '.modal-trigger', (e) ->
    e.preventDefault()
    $('.modal').openModal(opacity: .8)

  $(document).on 'click', '.signup-modal-close', (e) ->
    e.preventDefault()
    $('.modal').closeModal()

personalizeCta = ->
  sign_up_btn = $('.sign-up-btn')
  return unless sign_up_btn.length

  new_btn = switch
    when personalizationMatch('materialize')
      text: 'Create free website with Materialize'
      href: 'http://app.closeheat.com/apps/template?closeheat_demo&github_repo=closeheat/template-materializecss'
    when personalizationMatch('react')
      text: 'Create free website with React'
      href: 'http://app.closeheat.com/apps/template?closeheat_demo&github_repo=closeheat/template-reactjs'

  return unless new_btn
  sign_up_btn.html(new_btn.text).prop('href', new_btn.href)

personalizationMatch = (name) ->
  document.referrer.match(///#{name}///) || window.location.search.match(///#{name}///)

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
      url: 'https://formspree.io/domas.bitvinskas@me.com'
      method: 'POST'
      dataType: 'json'
      data:
        email: $('#your-email').val()
        message: $('#your-message').val()
    ).then (err, resp) ->
      $('#drop-a-line').addClass('hide')

      if resp == 'success'
        $('#thanks-note').removeClass('hide')
      else
        $('#error-note').removeClass('hide')
