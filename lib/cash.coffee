# cash.coffee
# The main Cash library. Modeled off of and inspired by CoffeeScript:
# https://github.com/jashkenas/coffee-script/blob/master/src/coffee-script.coffee

Coffee = require 'coffee-script'
FS = require 'fs'
Module = require 'module'
Path = require 'path'

# Compile a string of Cash to JavaScript:
@compile = (code, opts={}) ->
    # XXX using just coffeescript for now; TODO implement features! =)
    Coffee.compile code, opts

# Compile and execute a string of Cash, correctly setting `__filename`,
# `__dirname` and relative `require()`:
@run = (code, opts={}) ->
    module = require.main

    # set the filename:
    filename = module.filename = process.argv[1] =
        if opts.filename then FS.realpathSync opts.filename else '.'

    # clear the module cache:
    module.moduleCache and= {}

    # assign paths for node_modules loading:
    module.paths = Module._nodeModulePaths Path.dirname filename

    # finally, compile and run:
    # TODO do we need to do an extension check here like CoffeeScript does?
    module._compile @compile(code, opts), filename
