# Markdown Engine Wrapper - Use Your Markdown Library of Choice in Ruby

* [geraldb.github.com/markdown](http://geraldb.github.com/markdown)

The Markdown Engine Wrapper (`markdown`) Ruby gem lets you use
your markdown library of choice. Preconfigured markdown libraries include

* `kramdown`
* `redcarpet`
* `bluecloth`
* `maruku`
* `rpeg-markdown`
* `rdiscount`
* `pandoc-ruby`

## Usage - Ruby Code

    require 'markdown'
    
    Markdown.new( 'Hello World' ).to_html
    
    # => "<p>Hello World</p>\n"


## Usage - Command Line

The `markdown` gem includes a little command line tool. Try `markdown -h` for details:

```
markdown - Lets you convert plain text documents to hypertext with your Markdown engine of choice
  and preprocessing text filters.

Usage: markdown [options] files_or_dirs
    -o, --output PATH                Output Path
    -v, --verbose                    Show debug trace


Examples:
  markdown                   # Process all documents in working folder (that is, .)
  markdown quickref          # Process document or folder using Markdown
  markdown quickref.text     # Process document using Markdown
  markdown -o site quickref  # Output documents to site folder
```

## Configuration - Markdown Engine Loading Order

The default (fallback) Markdown library is `kramdown`. To use your markdown engine of choice
configure the wrapper. The wrapper
uses the following lookup order to find the markdown engine:

### 1) `MARKDOWN_LIB` Environment Variable

Example:

    set MARKDOWN_LIB=kramdown

### 2) `lib` Property (in `./markdown.yml` or `~/markdown.yml`)

Example:

    lib: kramdown

### 3) `libs` Property (in `./markdown.yml` or `~/markdown.yml`)

Example:

    libs:
      - redcarpet
      - kramdown


Markdown libraries in the list get loaded on a first-come first-serve principle,
that is, the first library `require`'d successfully will get used.



## Configuration - Markdown Engine Options

You can also pass along options to your Markdown library. Example:

    ## Let's use the Redcarpet library
    
    lib: redcarpet
    
    redcarpet:
      extensions:
        - no_intra_emphasis
        - fenced_code_blocks
        - tables
        - strikethrough


## Configuration -Filters (Command Line Only)

For the command line tool only you can configure preprocessing filters to
allow comments, Ruby helpers, and much more. Example:

    ## Let's use percent style comments
    
    filters:
      - comments-percent-style

Now the filter will strip comment lines starting with percent (that is, %). Example:

    %%%%%%%%%%%%%%%%
    % Some Headers
    
    Title: Web Services REST-Style: Universal Identifiers, Formats & Protocols

Becomes

    Title: Web Services REST-Style: Universal Identifiers, Formats & Protocols

before the text gets passed along to the markdown engine. The filter
also supports multiline comments with `%begin`|`comment`|`comments`/`%end` pairs. Example:

    %begin
    Using modern browser such as Firefox, Chrome and Safari you can
    now theme your slide shows using using "loss-free" vector graphics
    in plain old CSS. Thanks to gradient support in backgrounds in CSS3.
    %end

or

    %comment
    Using modern browser such as Firefox, Chrome and Safari you can
    now theme your slide shows using using "loss-free" vector graphics
    in plain old CSS. Thanks to gradient support in backgrounds in CSS3.
    %end

Note: As a shortcut using a single `%end` directive (that is, without a leading `%begin`)
will skip everything until the end of the document.

For more about filters see the [`textutils`](http://geraldb.github.com/textutils) gem.


## Configuration - Converters

The Markdown wrapper lets you configure different converter methods
for each markdown engine. By default
the converter method `<lib>_to_html` gets used
(for example, the default converter for `kramdown` is `kramdown_to_html`).

Example:

    pandoc-ruby:
      converter: pandoc-ruby-to-s5


## Install

Just install the gem:

    $ gem install markdown


## Real World Usage

The [`slideshow`](http://slideshow.rubyforge.org) (also known as Slide Show (S9)) gem
that lets you create slide shows
and author slides in plain text using a wiki-style markup language that's easy-to-write and easy-to-read.


## Alternatives

* [`multi_markdown`](https://github.com/postmodern/multi_markdown) gem by Hal Brodigan (aka postmodern)
* [`markdown_meta`](https://github.com/headius/markdown_meta) gem by Charles Oliver Nutter (aka headius)

## Questions? Comments?

Send them along to the
[Free Web Slide Show Alternatives (S5, S6, S9, Slidy And Friends) Forum/Mailing List](http://groups.google.com/group/webslideshow).
Thanks!


## License

The `markdown` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.