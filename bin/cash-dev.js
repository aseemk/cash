#!/usr/bin/env node

// register CoffeeScript and Streamline handlers:
require('coffee-script');
require('streamline').register();

// *then* do the normal cash thing:
require('./cash');
