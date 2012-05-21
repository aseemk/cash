#!/usr/bin/env node

// Modeled off of CoffeeScript's executable:
// https://github.com/jashkenas/coffee-script/blob/master/bin/coffee
// But modified to path.join() everything -- no hardcoded slashes.

var path = require('path');
var fs   = require('fs');
var lib  = path.join(path.dirname(fs.realpathSync(__filename)), '..', 'lib');

require(path.join(lib, 'command')).run();
