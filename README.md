# Cash (WIP)

CoffeeScript shell language. Like Bash, but Cash.

Bash (like most other shell languages) is fantastic at working with files and
processes. It (like most other shell languages) sucks in most other language
features, particularly syntax and control flow.

CoffeeScript is a fantastic language (better than most other high-level
programming languages), particularly in syntax and control flow. It (like most
other high-level programming languages) sucks at working with files and
processes. [1]

We can't change the language features of Bash, but we can add convenience APIs
to CoffeeScript. And thus, Cash was born.

This is a work in progress, starting from scratch. Follow along, submit your
feature ideas, contribute code, or just spread the word.

## Ideas

(All instances of "would" below are shorthand for "could/should/would".)

What a hello-world Cash script might look like:

```coffee
#!/usr/bin/env cash

echo 'hello world!'
```

You'd be writing CoffeeScript, but you'd have access to common shell tools
directly in the global namespace. This could be achieved by the cash binary
executing some common code before each script, e.g. (in CoffeeScript):

```coffee
cash = require 'cash'
{echo, ls, cat, …} = cash.tools # or utils or whatever
```

As the above example shows, Cash would be a library, too, so that you could
use these helpers in regular CoffeeScript code as well, e.g. a Cakefile.

One of Bash's <del>monstrosities</del> differences from high-level scripting
languages is how it handles commands' output (redirects them to stdout) vs.
their success/error status (returns exit codes). Commands in Cash would always
return their output, throwing an error if they failed. (Need to figure out how
to pass things to commands that *require* input from stdin. Are there any?)

This would let you work with I/O like you're used to:

```coffee
#!/usr/bin/env cash

try
    echo cat 'README.md'
catch err
    echo 'Uh oh, failed to read readme: ', err
```

The `echo cat README.md` line is interesting. That's vanilla CoffeeScript,
which is nice and normal for regular high-level languages, but that would use
piping in Bash: `cat README.md | echo`. *(This is a silly example because echo
doesn't use stdin, so help me think of a better but still simple example!)*

Unfortunately, supporting the pipe operator wouldn't be trivial, but it might
be possible if we parse the CoffeeScript AST and transform pipe operators into
the normal chain/wrap syntax above. That might be a cool thing to explore down
the line for the `<` and `>` redirect operators too. But it's not urgent.

You can see so far though that scripts should "read" synchronously. For a
shell script, you definitely don't want to deal with asynchronicity *by
default*. I don't believe Node provides synchronous APIs for shell execution,
so either these wrappers would have to be native extensions for Node, or we'd
run Cash scripts through [Streamline](https://github.com/Sage/streamlinejs)
(but that'd require scripts to use `_`, which would be nice to avoid).

## License

MIT. &copy; 2012 Aseem Kishore.

## Credits

I've been thinking about this for a while, but a definite hat-tip to the
[Plumbum](http://plumbum.readthedocs.org/) project for some inspiration.

## Footnotes

[1] http://stackoverflow.com/questions/3637668/why-are-scripting-languages-e-g-perl-python-ruby-not-suitable-as-shell-lang
