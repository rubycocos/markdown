module Markdown
  module Engine
   
    def maruku_to_html( content )
      Maruku.new( content, {:on_error => :raise} ).to_html
    end

  end # module Engine
end # module Markdown        