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
        @getLoginStatus @options.callback 
      
      @bind "onGetFriends", @builFriendList

    builFriendList: (args) ->
      console.debug "friends:builFriendList", args
      frags = horn.f.map(@buildDomFragment, args[0])
      console.log "xxxxxxxxxx", frags
      

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



