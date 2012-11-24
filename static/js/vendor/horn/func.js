
define([
], 
function () {

    "use strict";

    var slice = Array.prototype.slice;

    function _assert(pred, msg) {
        if (!pred) { throw new TypeError(msg); }
    }

    function _refute(pred, msg) {
        _assert(!pred, msg);
    }

    function isSeq(seq) {
        return !!seq &&
            typeof seq === "object" &&
            typeof seq.length === "number" &&
            !seq.tagName;
    }

    function toSeq(value, begin) {
        // From MDN:
        // Slice does not alter the original array, but returns a new 
        // "one level deep" copy... that can also be called to convert 
        // Array-like objects / collections to a new Array.
        begin = begin || 0;
        if (toString.call(value) === "[object Array]") { return value; }
        if (isSeq(value)) { return slice.call(value, begin); }
        if (typeof value === "undefined" || value === null) { return []; }
        return slice.call(arguments, begin);
    }

    function doall(fn, seq) {
        var i, l;
        for (i = 0, l = seq.length; i < l; ++i) {
            fn(seq[i], i, seq);
        }
    }

    function makePartial(fn) {
        var stored_args = toSeq(arguments, 1);
        return function() {
            var new_args = toSeq(arguments),
                args = stored_args.concat(new_args);
            return fn.apply(null, args);
        }
    }

    function prop(name) {
        return function (object) {
            return object[name];
        };
    }

    function setProp(properties, element) {
        var name;
        properties = properties || {};
        for (name in properties) {
            if (properties.hasOwnProperty(name)) {
                element[name] = properties[name];
            }
        }
    }

    function map(func, seq) {
        var i, l, new_seq = [];
        for (i=0, l=seq.length; i < l; i++) {
            new_seq.push( func(seq[i]) );
        }
        return new_seq;
    }

    function compose(funcs, context) {
        var funcs = toSeq(funcs);
        return function () {
            var result = arguments,
                i = funcs.length;
            while (i--) {
                result = [funcs[i].apply(context || this, result)];
            }
            return result[0];
        };
    }


    return {
        isSeq: isSeq,
        toSeq: toSeq,
        doall: doall,
        makePartial: makePartial,
        prop: prop,
        setProp: setProp,
        map: map,
        compose: compose
    };

});


    