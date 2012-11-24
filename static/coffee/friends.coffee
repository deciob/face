define [
  'jquery'
  'underscore'
  'asevented'
  'horn'
  'facebook'
], ($, _, asEvented, horn, facebook) ->
  'use strict'

  class Friends

    # Mixin an event emitter
    asEvented.call @prototype
    # Mixin a facebook provider
    _(@prototype).extend facebook

    constructor: (@options) ->
      console.debug "friends:constructor", @

      options.login_link.on "click", (e) => 
        e.preventDefault()
        @transitToWaitState()
        @getLoginStatus @options.callback 
      
      @bind "onGetFriends", @builFriendList

    builFriendList: (args) ->
      console.debug "friends:builFriendList", args
      #frags = horn.f.map(@buildDomFragment, args[0])

      transitToShowState()

      comp = horn.f.compose([@appendDomFragment, @buildDomFragment])
      frags = horn.f.map(comp, args[0])

      
      

    buildDomFragment: (user) ->
      console.debug "friends:buildDomFragment", user
      e = horn.dom.el
      img = e.img 
        "src": "http://graph.facebook.com/#{user.id}/picture"
        "alt": user.name
        "className": "img-placeholder no-padding",
        []
      p = e.p {}, [user.name]
      e.li {"className": "friend"}, [img, p]

    appendDomFragment: (fragment) ->
      console.log "xxxxxxxxxx", fragment
      # TODO: hardcoding selector for now....
      $("#face-list").append fragment


    transitToWaitState: ->
      $("#login-info-entry").hide()
      $("#login-info-wait").show()

    transitToShowState: ->
      $("#login-wrapper").hide()
      $("#friends-wrapper").show()

