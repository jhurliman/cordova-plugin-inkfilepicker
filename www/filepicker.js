/**
 * This class provides an interface to the camera roll native code.
 * @constructor
 */
var argscheck = require('cordova/argscheck'),
    utils = require("cordova/utils"),
    exec = require("cordova/exec");

var filepicker = {
    getFile: function(options, callback) {
        exec(function(info) { callback(null, info); }, callback,
            "CDVFPPicker", "getFile", [options]);
    }
};
module.exports = filepicker;
