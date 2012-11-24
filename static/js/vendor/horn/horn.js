
define([
    'func', 
    'dom'
], 
function (f, dom) {

    return {f: f, dom: dom};

});



//if (typeof define === "function" && define.amd) {
//  define("horn", [], function() {
//    return horn;
//  });
//}


//!function (definition) {
//    if (typeof define === "function" && define.amd) {
//        // Register as an AMD module.
//        define(definition);
//    } else {
//        // Browser globals
//        window.onDomReady = definition();
//    }
//}(function() {