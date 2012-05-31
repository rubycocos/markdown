module Markdown
 
  class Proxy

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
    
  end # class Proxy


  @@config = nil

  def self.lib
    if @@config.nil?
      @@config = Config.new
      
      load_markdown_libs
    
      # lets you use differnt options/converters for a single markdown lib
      @@markdown_mn = @@markdown_config.markdown_to_html_method( @@markdown_libs.first )
    end

    @@markdown_libs.first
  end
  
  def self.new( content, options={} )

    ## todo: allow options to pass in
    ##   lets you change markdown engine/converter for every call
    ##   e.g. lets you add config properties (as headers) to your document (for example)
    
    if @@markdown_config.nil?
      @@markdown_config = Config.new
      @@markdown_config.load
      
      load_markdown_libs
    
      # lets you use differnt options/converters for a single markdown lib
      @@markdown_mn = @@markdown_config.markdown_to_html_method( @@markdown_libs.first )    
    end

    Proxy.new( @@markdown_libs.first, @@markdown_mn, content, options )
  end

end # module Markdown