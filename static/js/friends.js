// Generated by CoffeeScript 1.4.0

define(['jquery', 'underscore', 'horn', 'facebook'], function($, _, horn, facebook) {
  'use strict';

  var Friends;
  return Friends = (function() {

    _(Friends.prototype).extend(facebook);

    function Friends(options) {
      this.options = options;
      console.debug("friends:constructor", this);
    }

    return Friends;

  })();
});
