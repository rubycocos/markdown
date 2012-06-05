module Markdown
  module Engine
   
    def rdiscount_to_html( content, options={} )
      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library rdiscount..."      
      
      RDiscount.new( content ).to_html
    end

  end # module Engine
end # module Markdown    