// Generated by CoffeeScript 1.4.0

define(['jquery'], function($) {
  'use strict';

  var facebook, getFriends, getLoginStatus, login, testAPI;
  window.fbAsyncInit = function() {
    return FB.init({
      appId: "463955970313826",
      channelUrl: "http://radiant-wave-5172.herokuapp.com/channel",
      status: true,
      cookie: true,
      xfbml: true
    });
  };
  login = function(callback) {
    return FB.login(function(response) {
      if (response.authResponse) {
        return callback();
      } else {
        return console.debug("login # cancelled");
      }
    });
  };
  testAPI = function() {
    console.log("Welcome!  Fetching your information.... ");
    return FB.api("/me", function(response) {
      return console.log("Good to see you, " + response.name + ".");
    });
  };
  getLoginStatus = function(callback) {
    var _this = this;
    return FB.getLoginStatus(function(response) {
      if (response.status === "connected") {
        return callback.call(_this);
      } else if (response.status === "not_authorized") {
        return login(callback);
      } else {
        return login(callback);
      }
    });
  };
  getFriends = function() {
    var _this = this;
    return FB.api("/me/friends", function(response) {
      if (response.data) {
        return _this.trigger("onGetFriends", [response.data]);
      } else {
        return console.debug("facebook:getFriends:Error!");
      }
    });
  };
  return facebook = {
    login: login,
    testAPI: testAPI,
    getLoginStatus: getLoginStatus,
    getFriends: getFriends
  };
});
