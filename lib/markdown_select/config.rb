module MarkdownSelect

  class Config
  
    def initialize
      @hash = {}
    end

    
    def load   
      # todo/fix: check more locations; merge config files

      # check for user settings in working folder (check for slideshow.yml)
    
      config_user_file = "./markdown.yml"
      if File.exists?( config_user_file )
        puts "Loading settings from '#{config_user_file}'..."
        @hash[ 'user' ] = YAML.load_file( config_user_file )   
      end         
    end

    
    def markdown_to_html_method( lib )    
      method = @hash.fetch( 'user', {} ).fetch( lib, {} ).fetch( 'converter', nil )
    
      # use default name
      if method.nil?
        method = "#{lib.downcase}_to_html"
      end
    
      method.tr('-','_').to_sym
    end  

    
# note: only kramdown is listed as a dependency in gem specs (because it's Ruby only and, thus, easy to install)
#  if you want to use other markdown libs install the required/desired lib e.g.
#  use  gem install rdiscount for rdiscount and so on
#
# also note for now the first present markdown library gets used
#  the search order is first come, first serve, that is: rdiscount, rpeg-markdown, maruku, bluecloth, kramdown (fallback, always present)

  BUILTIN_LIBS = [
    'pandoc-ruby',
    'rdiscount',
    'rpeg-markdown',
    'maruku',
    'bluecloth',
    'kramdown'    
  ]
  
    def known_markdown_libs
      # returns an array of known markdown engines e.g.
      # [ pandoc-ruby, rdiscount, rpeg-markdown, maruku, bluecloth, kramdown ]
    
      ## todo: allow single lib para instead of libs    
      ##  todo: allow ENV setting markdown_[select]_lib=xxxx
    
      user_libs = @hash.fetch( 'user', {} ).fetch( 'libs', [] )
    
      user_libs.length > 0 ? user_libs : BUILTIN_LIBS
    end

  end # class Config
end # module MarkdownSelect