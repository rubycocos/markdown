module Markdown
  module Engine
   
    def pandoc_ruby_to_html( content, options={} )
      puts "  Converting Markdown-text (#{@content.length} bytes) to HTML using library pandoc_ruby..."

      content = PandocRuby.new( content, :from => :markdown, :to => :html ).convert
    end
  
    def pandoc_ruby_to_html_incremental( content, options={} )
      content = PandocRuby.new( content, :from => :markdown, :to => :html ).convert
      content = content.gsub(/<(ul|ol)/) do |match|
        "#{Regexp.last_match(0)} class='step'"
      end
      content
    end
  
    # sample how to use your own converter
    # configure in markdown.yml
    # pandoc-ruby:
    #  converter: pandoc-ruby-to-s5
  
    def pandoc_ruby_to_s5( content, options={} )
      content = PandocRuby.new( content, {:from => :markdown, :to => :s5}, :smart ).convert
      content = content.gsub(/class="incremental"/,'class="step"')
      content = content.to_a[13..-1].join # remove the layout div
    end

    def pandoc_ruby_to_s5_incremental( content, options={} )
      content = PandocRuby.new( content, {:from => :markdown, :to => :s5 }, :incremental, :smart ).convert
      content = content.gsub(/class="incremental"/,'class="step"')
      content = content.to_a[13..-1].join # remove the layout div
    end
    
  end # module Engine
end # module Markdown