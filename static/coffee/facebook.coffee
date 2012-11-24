define [
  'jquery'
], ($) ->
  'use strict'

  window.fbAsyncInit = ->
    console.debug "window.fbAsyncInit"
    FB.init
      appId: "463955970313826" # App ID
      channelUrl: "http://radiant-wave-5172.herokuapp.com/channel" # Channel File
      status: true # check login status
      cookie: true # enable cookies to allow the server to access the session
      xfbml: true # parse XFBML  
  
  login = (callback) ->
    console.debug "login", FB
    FB.login (response) ->
      if response.authResponse
        console.debug "login # connected"
        callback()
      else
        console.debug "login # cancelled"

  testAPI = ->
    console.log "Welcome!  Fetching your information.... "
    FB.api "/me", (response) ->
      console.log "Good to see you, " + response.name + "."
  
  # Get login status, if not logged-in try to log-in and fire callback.
  getLoginStatus = (callback) ->
    #@trigger "onGetFriends", ["xxxxx"]
    console.debug "facebook:getLoginStatus", @
    FB.getLoginStatus (response) =>
      if response.status is "connected"
        console.debug "connected"
        callback.call @
      else if response.status is "not_authorized"
        console.debug "not_authorized"
        login callback
      else
        console.debug "not_logged_in"
        login callback

  getFriends = ->
    console.debug "facebook:getFriends", @
    FB.api "/me/friends", (response) =>
      if response.data
        console.debug response.data, @
        @trigger "onGetFriends", [response.data]
      else
        console.debug "facebook:getFriends:Error!"

  facebook = 
    login: login
    testAPI: testAPI
    getLoginStatus: getLoginStatus
    getFriends: getFriends
