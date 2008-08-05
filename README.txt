= googlepagerank
* by Fran Dieguez
* http://googlepagerank.rubyforge.org/

== DESCRIPTION:

Ruby gem for fetching Google PageRank®. It returns the value of the Google PageRank® for a given domain name.

Googlepagerank calculation is powered and based on http://www.math.kobe-u.ac.jp/~kodama/gprank.rb

== FEATURES/PROBLEMS:

* Return the Google PageRank@ of a given domain name

== SYNOPSIS:

# Require all gems and libs needed...
require 'rubygems'

require 'googlepagerank'

# Fetching the page_rank

page_rank = Googlepagerank.get(domain,port)

# See extracted data...

page_rank

== REQUIREMENTS:

* net/http

== INSTALL:

* sudo gem install googlepagerank

== LICENSE:

(The MIT License)

Copyright (c) 2008 Fran Dieguez

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
