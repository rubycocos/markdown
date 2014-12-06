# encoding: utf-8

module Markdown
  module Engine

    def maruku_version
      Maruku::VERSION
    end

    def maruku_to_html( content, options={} )
      puts "  Converting Markdown-text (#{content.length} bytes) to HTML using library maruku..."
            
      Maruku.new( content, {:on_error => :raise} ).to_html
    end

  end # module Engine
end # module Markdown