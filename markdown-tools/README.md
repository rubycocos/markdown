# markdown-tools gem - markdown command line tools

* home  :: [github.com/rubylibs/markdown-tools](https://github.com/rubylibs/markdown-tools)
* bugs  :: [github.com/rubylibs/markdown-tools/issues](https://github.com/rubylibs/markdown-tools/issues)
* gem   :: [rubygems.org/gems/markdown-tools](https://rubygems.org/gems/markdown-tools)
* rdoc  :: [rubydoc.info/gems/markdown-tools](http://rubydoc.info/gems/markdown-tools)




## Usage - Command Line

The `markdown-tools` gem includes a little command line tool. Try `markdown -h` for details:

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
    
    Note:
      markdown server            # Starts builtin markdown server
                                 #   (aliases for server include serve, service, s)



## Install

Just install the gem:

    $ gem install markdown-tools



## License

The `markdown-tools` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Free Web Slide Show Alternatives (S5, S6, S9, Slidy And Friends) Forum/Mailing List](http://groups.google.com/group/webslideshow).
Thanks!
