module Markdown
 
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
  
  def self.lib=( value )
      ## todo: lets you select your library    
  end
  
  def self.lib
    if @@config.nil?
      @@config = Config.new
    end
    @@config.markdown_lib
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
  
  
  def self.new( content, options={} )

    ## todo: allow options to pass in
    ##   lets you change markdown engine/converter for every call
    ##   e.g. lets you add config properties (as headers) to your document (for example)
    
    if @@config.nil?
      @@config = Config.new
    end

    lib      = @@config.markdown_lib
    mn       = @@config.markdown_to_html_method # lets you use differnt options/converters for a single markdown lib   
    defaults = @@config.markdown_lib_defaults  ## todo/fix: use mn / converter from defaults hash?? mn no longer needed??    

    props = Props.new( options, 'USER', Props.new( defaults, 'SYSTEM' ))
    
    Wrapper.new( lib, mn, content, props )
  end

end # module Markdown