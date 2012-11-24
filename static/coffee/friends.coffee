define [
  'jquery'
  'underscore'
  'horn'
  'facebook'
], ($, _, horn, facebook) ->
  'use strict'

  class Friends

    # Mixin an facebook provider
    _(@prototype).extend facebook

    constructor: (@options) ->
      console.debug "friends:constructor", @
