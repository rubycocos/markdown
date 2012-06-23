module Markdown

class Runner

  attr_reader :logger
  attr_reader :opts
    
  def initialize
    @logger       = Logger.new(STDOUT)
    @logger.level = Logger::INFO
    @opts         = Opts.new
  end

  def has_markdown_extension?( fn )
    dirname  = File.dirname( fn )
    basename = File.basename( fn, '.*' )
    extname  = File.extname( fn )
    logger.debug "dirname=#{dirname}, basename=#{basename}, extname=#{extname}"

    return false if extname.empty?   # no extension
      
    Markdown.extnames.include?( extname.downcase )
  end
    
  def find_file_with_markdown_extension( fn )
    dirname  = File.dirname( fn )
    basename = File.basename( fn, '.*' )
    extname  = File.extname( fn )
    logger.debug "dirname=#{dirname}, basename=#{basename}, extname=#{extname}"

    Markdown.extnames.each do |e|
      newname = File.join( dirname, "#{basename}#{e}" ) 
      logger.debug "File.exists? #{newname}"
      return newname if File.exists?( newname )
    end  # each extension (e)
      
    nil   # not found; return nil
  end

    
  def find_files( file_or_dir_or_pattern )

    filtered_files = []
      
    # assume pattern if includes * or ? or {} or []
    if file_or_dir_or_pattern =~ /[*?{}\[\]]/
      puts "searching glob pattern '#{file_or_dir_or_pattern}'..."
      Dir.glob( file_or_dir_or_pattern ).each do |file|
        if File.directory?( file )  # skip (sub)directories
          puts "  skipping folder '#{file}'..."
          next
        else
          if has_markdown_extension?( file )
            logger.debug "  adding file '#{file}'..."
            filtered_files << file
          else
            puts "  skipping file   '#{file}'..."
          end
        end
      end
    elsif File.directory?(file_or_dir_or_pattern)
      puts "searching folder '#{file_or_dir_or_pattern}'..."
      Dir.entries( file_or_dir_or_pattern ).each do |entry|
        next if entry == '.' || entry == '..' # silently skip current and up dirs
          
        if file_or_dir_or_pattern == '.'
          file = entry
        else  # add dir (if not working dir)
          file = File.join( file_or_dir_or_pattern, entry )  
        end
           
        if File.directory?( file )  # skip (sub)directories
          puts "  skipping folder '#{file}'..."
          next
        else
          if has_markdown_extension?( file )
            logger.debug "  adding file '#{file}'..."
            filtered_files << file
          else
            puts "  skipping file   '#{file}'..."
          end
        end
      end
    else  # assume it's a single file (check for missing extension)
      if File.exists?( file_or_dir_or_pattern )
        file = file_or_dir_or_pattern
        if has_markdown_extension?( file )
          logger.debug "  adding file '#{file}'..."
          filtered_files << file
        else
          puts "  skipping file   '#{file}'..."
        end
      else  # check for existing file w/ missing extension
        file = find_file_with_markdown_extension( file_or_dir_or_pattern )
        if file.nil?
          puts "  skipping missing file '#{file_or_dir_or_pattern}{#{Markdown.extnames.join(',')}}'..."
        else
          logger.debug "  adding file '#{file}'..."
          filtered_files << file
        end
      end
    end

    filtered_files
  end  # find_files
  
    
    def run( args )
      opt=OptionParser.new do |cmd|
    
        cmd.banner = "Usage: markdown [options] files_or_dirs"
    
        cmd.on( '-o', '--output PATH', "Output Path (default is #{opts.output_path})" ) { |path| opts.output_path = path }

        cmd.on( '-v', '--version', "Show version" ) do
          puts Markdown.banner
          exit
        end
        
        cmd.on( '--about', "(Debug) Show more version info" ) do
          puts
          puts Markdown.banner
          puts

          # dump settings
          Markdown.dump
          puts
          
          exit
        end

        cmd.on( "--verbose", "(Debug) Show debug trace" )  do
          logger.datetime_format = "%H:%H:%S"
          logger.level = Logger::DEBUG
        end
 
## todo: add markdown.lib options (e.g. extensions,etc)
 
        cmd.on_tail( "-h", "--help", "Show this message" ) do
           puts <<EOS

markdown - Lets you convert plain text documents (#{Markdown.extnames.join(', ')}) to hypertext (.html) with your Markdown engine of choice (#{Markdown.lib}) and preprocessing text filters (#{Markdown.filters.join(', ')}).

#{cmd.help}

Examples:
  markdown                   # Process all documents in working folder (that is, .)
  markdown quickref          # Process document or folder using Markdown
  markdown quickref.text     # Process document using Markdown
  markdown -o site quickref  # Output documents to site folder

Further information:
  http://geraldb.github.com/markdown
  
EOS
           exit
        end
      end

      opt.parse!( args )
  
      puts Markdown.banner
      
      # force loading of config
      Markdown.lib
      
      Markdown.dump   if logger.level == Logger::DEBUG   # dump settings if verbose/debug flag on

      
      logger.debug "args.length: #{args.length}"
      logger.debug "args: >#{args.join(',')}<"
      
      # if no file args given; default to working folder (that is, .)
      args = ['.'] if args.length == 0

      args.each do |arg|
        files = find_files( arg )
        files.each do |file|
          Gen.new( logger, opts ).create_doc( file )
        end
      end
      
      puts "Done."
      
    end   # method run 

end # class Runner
end # module Markdown
