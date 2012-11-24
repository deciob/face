// Generated by CoffeeScript 1.4.0

define(['jquery', 'underscore', 'asevented', 'horn', 'facebook'], function($, _, asEvented, horn, facebook) {
  'use strict';

  var Friends;
  return Friends = (function() {

    asEvented.call(Friends.prototype);

    _(Friends.prototype).extend(facebook);

    function Friends(options) {
      var _this = this;
      this.options = options;
      options.login_link.on("click", function(e) {
        e.preventDefault();
        _this.transitToWaitState();
        return _this.getLoginStatus(_this.options.callback);
      });
      $('input').on("keyup", function(e) {
        return _this.filterFriends(e.target.value);
      });
      this.bind("onGetFriends", this.builFriendList);
    }

    Friends.prototype.builFriendList = function(args) {
      var comp;
      this.transitToShowState();
      comp = horn.f.compose([this.appendDomFragment, this.buildDomFragment]);
      return horn.f.map(comp, args[0]);
    };

    Friends.prototype.buildDomFragment = function(user) {
      var e, img, p;
      e = horn.dom.el;
      img = e.img({
        "src": "http://graph.facebook.com/" + user.id + "/picture",
        "alt": user.name,
        "className": "img-placeholder no-padding"
      }, []);
      p = e.p({}, [user.name]);
      return e.li({
        "className": "friend"
      }, [img, p]);
    };

    Friends.prototype.appendDomFragment = function(fragment) {
      return $("#face-list").append(fragment);
    };

    Friends.prototype.filterFriends = function(filter) {
      var _this = this;
      console.debug('xxxxxxxxxx', filter);
      return $("#face-list").children().each(function(idx, el) {
        var friend, li;
        li = $(el);
        friend = li.find('p').html().toLowerCase();
        if (friend.indexOf(filter.toLowerCase(), 0) === -1) {
          return li.hide();
        } else {
          return li.show();
        }
      });
    };

    Friends.prototype.transitToWaitState = function() {
      $("#login-info-entry").hide();
      return $("#login-info-wait").show();
    };

    Friends.prototype.transitToShowState = function() {
      $("#login-wrapper").hide();
      return $("#friends-wrapper").show();
    };

    return Friends;

  })();
});
