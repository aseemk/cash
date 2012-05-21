CP = require 'child_process'
Path = require 'path'


# Constants:

CASH_PATH = Path.normalize Path.join __dirname, '..', 'bin', 'cash-dev.js'


# Helpers:

# Wraps CP.execFile to support auto-piping stdout and stderr via a new `pipe`
# option while still being Streamline-friendly:
CP.execFile_orig = CP.execFile
CP.execFile = (file, args=[], opts={}, callback) ->
    proc = CP.execFile_orig.apply CP, arguments
    if opts.pipe
        proc.stdout.pipe process.stdout
        proc.stderr.pipe process.stderr
    proc

# Executes the test with the given name:
execTest = (test, _) ->
    testPath = Path.join __dirname, test
    CP.execFile CASH_PATH, [testPath], {pipe: true}, _

execTest 'misc', _
