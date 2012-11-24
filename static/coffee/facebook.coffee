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
  
  login = ->
    console.debug "login", FB
    FB.login (response) ->
      if response.authResponse
        console.debug "login # connected"
        testAPI()
      else
        console.debug "login # cancelled"

  testAPI = ->
    console.log "Welcome!  Fetching your information.... "
    FB.api "/me", (response) ->
      console.log "Good to see you, " + response.name + "."
  
  # Get login status and try to log-in if not already.
  getLoginStatus = ->
    FB.getLoginStatus (response) ->
      if response.status is "connected"
        console.debug "connected"
        testAPI()
      else if response.status is "not_authorized"
        console.debug "not_authorized"
        login()
      else
        console.debug "not_logged_in"
        login()

  facebook = 
    login: login
    testAPI: testAPI
    getLoginStatus: getLoginStatus
