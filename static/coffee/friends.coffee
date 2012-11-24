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
      @buildDomFragment(args)
      #<li class="friend"><div class="img-placeholder male no-padding">
      #<img src="https://graph.facebook.com/1534405209/picture" alt="Alberto Nityanand Cogliani">
      #</div>
      #<p>Alberto Nityanand Cogliani</p>
      #<div class="tag-icons">
      #<div class="smartphone tag-icon" data-content="Alberto has a smartphone."></div>
      #</div></li>

    buildDomFragment: (data) ->
      e = horn.dom.el
      img = e.img {"src": "xxx"}
      li = e.li {"className": "friend"}
      console.log "zzzzzzzzzz", img, li



