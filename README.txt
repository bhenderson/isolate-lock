= isolate-lock

* https://github.com/bhenderson/isolate-lock

== DESCRIPTION:

Plugin for Isolate to lock gem dependencies. The problem that I'm trying to
solve is that while it's standard practice to be specific about gem
dependencies in your Isolate file, those gems might depend on other gems and
their dependecy graph might be too loose for your liking.

== FEATURES/PROBLEMS:

* needs tests :(
* let me know what you think!

== SYNOPSIS:

Require the gem before isolate.
  require 'isolate/lock'
  require 'isolate/now'

Make it optional so only your dev box needs the gem and not your server
  begin
    require 'isolate/lock'
  rescue LoadError
    # lock file will not be updated.
  end
  require 'isolate/now'

Then add one line at the bottom of your Isolate file.
  load 'Isolate.lock'

== REQUIREMENTS:

* isolate

== INSTALL:

* gem install isolate-lock

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

== LICENSE:

(The MIT License)

Copyright (c) 2013 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
