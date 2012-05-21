# command.coffee
# The main Cash executable. Modeled off of and inspired by CoffeeScript:
# https://github.com/jashkenas/coffee-script/blob/master/src/command.coffee

Cash = require './cash'
FS = require 'fs'

# Run `cash` by parsing passed options and determining what action to take.
# Many flags cause us to divert before compiling anything. Flags passed after
# `--` will be passed verbatim to your script as arguments in `process.argv`.
# TODO Actually implement a CLI!
@run = ->
    # change execPath and argv to match `#!/usr/bin/env node` behavior; e.g.
    # change from `node /path/to/cash filename` to `cash filename`:
    process.argv = process.argv[1..]
    process.argv[0] = 'cash'
    process.execPath = require.main.filename

    # run the main file!
    @runFile process.argv[1]

# Run a single source script:
# TODO More customizability?
@runFile = (path) ->
    Cash.run FS.readFileSync(path, 'utf8'),
        filename: path
