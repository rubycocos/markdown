module Markdown
 
  class Wrapper

    def initialize( lib, mn, content, options={} )
      @lib     = lib      
      @mn      = mn
      @content = content
      @options = options
    end
        
    def to_html
      # call markdown filter; turn markdown lib name into method_name (mn)
      # eg. rpeg-markdown =>  rpeg_markdown_to_html

      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library '#{@lib}' calling '#{@mn}'..."

      send( @mn, @content )  # call 1st configured markdown engine e.g. kramdown_to_html( content )
    end    

    include Engine
    
  end # class Wrapper



  @@config = nil

  def self.lib
    if @@config.nil?
      @@config = Config.new
    end

    @@config.markdown_lib
  end
  
  def self.new( content, options={} )

    ## todo: allow options to pass in
    ##   lets you change markdown engine/converter for every call
    ##   e.g. lets you add config properties (as headers) to your document (for example)
    
    if @@config.nil?
      @@config = Config.new
    end

    lib = @@config.markdown_lib
    mn  = @@config.markdown_to_html_method( lib ) # lets you use differnt options/converters for a single markdown lib   
    Wrapper.new( lib, mn, content, options )
  end

end # module Markdown