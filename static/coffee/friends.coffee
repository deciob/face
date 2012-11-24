define [
  'jquery'
  'underscore'
  'asevented'
  'horn'
  'facebook'
], ($, _, asEvented, horn, facebook) ->
  'use strict'

  class Friends

    # Mixin an facebook provider
    _(@prototype).extend facebook

    constructor: (@options) ->
      console.debug "friends:constructor", @

      options.login_link.on "click", (e) => 
        e.preventDefault()
        @getLoginStatus @options.callback 
      
      asEvented.bind "onGetFriends", @go


    go: (args) ->
      console.debug "friends:go", args



