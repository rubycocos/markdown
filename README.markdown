# Markdown Engine Wrapper - Use Your Markdown Library of Choice

* [geraldb.github.com/markdown](http://geraldb.github.com/markdown)

## Description

The Markdown Engine Wrapper (`markdown`) Ruby gem lets you use
your markdown library of choice. Preconfigured markdown libraries include:

* `kramdown`
* `bluecloth`
* `maruku`
* `rpeg-markdown`
* `rdiscount`
* `pandoc-ruby`


## Usage

    require 'markdown'
    
    Markdown.new( 'Hello World' ).to_html


## Install

Just install the gem:

    $ gem install markdown


## Configuration - Markdown Engine Loading Order

The default fallback loading order is:

`pandoc-ruby`, `kramdown`, `bluecloth`, `maruku`, `rpeg-markdown`, `rdiscount`

To use your markdown engine of choice configure the wrapper. The wrapper
uses the following lookup order to find the markdown engine to configure:

1) `MARKDOWN_LIB` environment variable

Example:

    set MARKDOWN_LIB=kramdown

2) `lib` property (in `./markdown.yml` or `~/markdown.yml`)

Example:

    lib: kramdown

3) `libs` property (in `./markdown.yml` or `~/markdown.yml`) - first-come first-serve markdown engine loading list (defaults to builtin list).

Example:

    libs:
      - rdiscount
      - kramdown


## Converters

The Markdown Wrapper lets you configure different converter methods for each markdown engine. By default
the converter method **lib**_to_html gets used
(for example, the default converter for kramdown is `kramdown_to_html`).

...

Example:

    pandoc-ruby:
      converter: pandoc-ruby-to-s5



## Real World Usage

The [`slideshow` (also known as Slide Show (S9))](http://slideshow.rubyforge.org) gem
that lets you create slide shows
and author slides in plain text using a wiki-style markup language that's easy-to-write and easy-to-read
ships with the `markdown` gem.


## Alternatives

[`multi_markdown`](https://github.com/postmodern/multi_markdown) Gem by Hal Brodigan 


## Questions? Comments?

Send them along to the
[Free Web Slide Show Alternatives (S5, S6, S9, Slidy And Friends) Forum/Mailing List](http://groups.google.com/group/webslideshow).
Thanks!


## License

The `markdown` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.