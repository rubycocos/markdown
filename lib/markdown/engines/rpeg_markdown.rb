module Markdown
  module Engine

    def rpeg_markdown_to_html( content, options={} )
      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library rpeg_markdown..."

      PEGMarkdown.new( content ).to_html
    end

  end # module Engine
end # module Markdown        