#!/usr/bin/env node

// Modeled off of CoffeeScript's executable:
// https://github.com/jashkenas/coffee-script/blob/master/bin/coffee
// But modified to path.join() everything -- no hardcoded slashes.

var path = require('path');
var fs   = require('fs');
var lib  = path.join(path.dirname(fs.realpathSync(__filename)), '..', 'lib');

// XXX FIXME how to compile coffeescript JIT during development?
require('coffee-script');

require(path.join(lib, 'command')).run();
