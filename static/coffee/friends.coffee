define [
  'jquery'
  'underscore'
  'asevented'
  'horn'
  'facebook'
], ($, _, asEvented, horn, facebook) ->
  'use strict'

  # Observations
  #
  # There are a lot of hard-coded element ids around the place here.
  # This could be thought out better. Some conventions in the DOM structure
  # maybe? And pass everything is needed into the constructor.
  #
  # `hornjs` is a lib I wrote, mostly ripping it off from:
  # https://github.com/magnars/culljs
  # The idea was not to write something original, but to understand some 
  # functional programming techniques.
  # `horn.dom` is a simplified version of `cull.dom`. Although very basic,
  # I think its implementation is very cool!

  class Friends

    # Mixin an event emitter
    asEvented.call @prototype
    # Mixin a facebook provider
    _(@prototype).extend facebook

    constructor: (@options) ->
      #console.debug "friends:constructor", @
      options.login_link.on "click", (e) =>
        e.preventDefault()
        @transitToWaitState()
        # `getLoginStatus` first checks if the user is logged-in,
        # and after successful login the callback is fired.
        # For more details and source code see the facebook module.
        @getLoginStatus @options.callback 
      $('input').on "keyup", (e) =>
        @filterFriends $("#face-list"), e.target.value
      # When and if the facebook api comes back with friends, build the list.
      @bind "onGetFriends", @builFriendList

    builFriendList: (args) ->
      #console.debug "friends:builFriendList", args
      @transitToShowState()
      # For every user build a `li` fragment and append it to the DOM.
      # Uses function composition, from right to left. 
      comp = horn.f.compose([@appendDomFragment, @buildDomFragment])
      horn.f.doall(comp, args[0])
    
    buildDomFragment: (user) ->
      #console.debug "friends:buildDomFragment", user
      e = horn.dom.el
      img = e.img 
        "src": "http://graph.facebook.com/#{user.id}/picture"
        "alt": user.name,
        []
      div = e.div
        "className": "img-placeholder no-padding", 
        [img]
      p = e.p {}, [user.name]
      e.li {"className": "friend"}, [div, p]

    appendDomFragment: (fragment) ->
      $("#face-list").append fragment
  
    filterFriends: (face_list, filter) ->
      face_list.children().each (idx, el) =>
        li = $(el)
        friend = li.find('p').html().toLowerCase()
        if friend.indexOf(filter.toLowerCase(), 0) == -1
          li.hide()
        else
          li.show()

    transitToWaitState: ->
      $("#login-info-entry").hide()
      $("#login-info-wait").show()

    transitToShowState: ->
      $("#login-wrapper").hide()
      $("#friends-wrapper").show()

