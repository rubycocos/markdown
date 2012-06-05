module Markdown
  module Engine

    def kramdown_to_html( content, options={} )

      h = {}
      
      # todo: find an easier (more generic?) way to setup hash - possible?
      h[ :auto_ids    ]   = options.fetch( 'auto_ids', nil )      if options.fetch( 'auto_ids',      nil )
      h[ :footnote_nr ]   = options.fetch( 'footnote_nr',nil )   if options.fetch( 'footnote_nr',   nil )
      h[ :entity_output ] = options.fetch( 'entity_output',nil ) if options.fetch( 'entity_output', nil )
      h[ :toc_levels ]    = options.fetch( 'toc_levels',nil )    if options.fetch( 'toc_levels',    nil )
      h[ :smart_quotes ]  = options.fetch( 'smart_quotes',nil )  if options.fetch( 'smart_quotes',  nil )

      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library kramdown (#{Kramdown::VERSION})"
      puts "  using options:"
      pp h    # todo: use inspect? or to_json?
      
      ## allow fenced blocks a la github flavored markup
      # -- thanks zenweb for inspiration:
      #  https://github.com/seattlerb/zenweb/blob/master/lib/zenweb/plugins/markdown.rb
      
      content = content.
        gsub(/^``` *(\w+)/) { "{:lang=\"#$1\"}\n~~~" }.
        gsub(/^```/, '~~~')
      
      Kramdown::Document.new( content, h ).to_html
    end

  end # module Engine
end # module Markdown