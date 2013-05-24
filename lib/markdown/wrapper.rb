module Markdown

  ## todo: use Converter  inside Wrapper to avoid duplication

  class Converter
    def initialize( lib, mn_to_html, mn_version )
      @lib         = lib
      @mn_to_html  = mn_to_html
      @mn_version  = mn_version
    end

    def convert( text, options={} )
      # call markdown filter; turn markdown lib name into method_name (mn)
      # eg. rpeg-markdown =>  rpeg_markdown_to_html
      send( @mn_to_html, text, options )  # call 1st configured markdown engine e.g. kramdown_to_html( content )
    end
    
    def version
      send( @mn_version )  # call 1st configured markdown engine e.g. kramdown_version
    end

    include Engine
  end


  class Wrapper

    def initialize( lib, mn, content, options={} )
      @lib      = lib
      @mn       = mn
      @content  = content
      @options  = options
    end

    def to_html
      # call markdown filter; turn markdown lib name into method_name (mn)
      # eg. rpeg-markdown =>  rpeg_markdown_to_html
      send( @mn, @content, @options )  # call 1st configured markdown engine e.g. kramdown_to_html( content )
    end

    include Engine

  end # class Wrapper



  @@config = nil

  def self.lib=( lib )
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_lib = lib
  end

  def self.lib
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_lib
  end

  def self.libs
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_libs
  end

  def self.extnames
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_extnames
  end

  def self.filters
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_filters
  end

  def self.dump   # dump settings for debug/verbose flag
    if @@config.nil?
      @@config = Config.new
    end
    @@config.dump
  end


  def self.create_converter( lib )
    if @@config.nil?
      @@config = Config.new
    end

    mn_to_html  = @@config.markdown_to_html_method( lib ) # lets you use differnt options/converters for a single markdown lib   
    mn_version  = @@config.markdown_version_method( lib )

    Converter.new( lib, mn_to_html, mn_version )
  end


  def self.new( content, options={} )

    ## options
    ## make sure keys are strings, that is, allow symbols for easy use
    ##  but internally only use string (yaml gets use strings)

    ## fix: use stringify_keys! from activesupport (include dependency ?? why? why not??)
    options.keys.each do |key|
      options[ key.to_s ] = options.delete(key)
    end


    ## todo: allow options to pass in
    ##   lets you change markdown engine/converter for every call
    ##   e.g. lets you add config properties (as headers) to your document (for example)
    
    if @@config.nil?
      @@config = Config.new
    end

    lib      = @@config.markdown_lib
    mn       = @@config.markdown_to_html_method( lib ) # lets you use differnt options/converters for a single markdown lib   
    defaults = @@config.markdown_lib_defaults( lib )  ## todo/fix: use mn / converter from defaults hash?? mn no longer needed??    

    props = Props.new( options, 'USER', Props.new( defaults, 'SYSTEM' ))
    
    Wrapper.new( lib, mn, content, props )
  end

end # module Markdown