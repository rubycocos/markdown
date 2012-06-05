module Markdown
  module Engine

    def redcarpet_to_html( content, options={} )
      
      ## NB: uses redcarpet2
      #
      # see https://github.com/tanoku/redcarpet
      
      extensions_ary = options.fetch( 'extensions', [] )
      
      extensions_hash = {}
      extensions_ary.each do |e|
        extensions_hash[ e.to_sym ] = true
      end

      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library redcarpet (#{Redcarpet::VERSION}) w/ HTML render"      
      puts "  using extensions: [#{extensions_ary.join(', ')}]"      
      
      redcarpet = Redcarpet::Markdown.new( Redcarpet::Render::HTML, extensions_hash )
      redcarpet.render( content )      
    end

  end # module Engine
end # module Markdown