# command.coffee
# The main Cash executable.

@run = ->
    console.error 'Running cash with the following execPath and argv:'
    console.error process.execPath
    console.error process.argv

    # TODO
