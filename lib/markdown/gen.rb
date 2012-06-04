module Markdown


  class Opts
  
    def output_path=(value)
      @output_path = value
    end
  
    def output_path
      @output_path ||= '.'
    end

  end # class Opts


  class Gen

    attr_reader :logger
    attr_reader :opts
    
    def initialize
      @logger       = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @opts         = Opts.new
    end


    def with_output_path( dest, output_path )
      dest_full = File.expand_path( dest, output_path )
      logger.debug "dest_full=#{dest_full}"
      
      # make sure dest path exists
      dest_path = File.dirname( dest_full )
      logger.debug "dest_path=#{dest_path}"
      FileUtils.makedirs( dest_path ) unless File.directory? dest_path
      dest_full
    end

    def create_doc( fn )
 
      # expand output path in current dir and make sure output path exists
      outpath = File.expand_path( opts.output_path ) 
      logger.debug "outpath=#{outpath}"
      FileUtils.makedirs( outpath ) unless File.directory? outpath 

      dirname  = File.dirname( fn )    
      basename = File.basename( fn, '.*' )
      extname  = File.extname( fn )
      logger.debug "dirname=#{dirname}, basename=#{basename}, extname=#{extname}"

      # change working dir to sourcefile dir
      # todo: add a -c option to commandline? to let you set cwd?
    
      newcwd  = File.expand_path( dirname )
      oldcwd  = File.expand_path( Dir.pwd )
    
      unless newcwd == oldcwd then
        logger.debug "oldcwd=#{oldcwd}"
        logger.debug "newcwd=#{newcwd}"
        Dir.chdir newcwd
      end  

      inname  =  "#{dirname}/#{basename}#{extname}"

      puts "Reading document '#{basename}#{extname} (in folder #{dirname})'..."
      
      
      logger.debug "inname=#{inname}"
    
      content = File.read( inname )

      # convert light-weight markup to hypertext

      content = Markdown.new( content ).to_html

      outname = "#{basename}.html"
      puts "Preparing #{outname} (in folder #{outpath})..."

      out = File.new( with_output_path( outname, outpath ), "w+" )
      out << "<!-- ======================================================================\n"
      out << "      generated by #{Markdown.banner}\n"
      out << "                on #{Time.now} with Markdown engine '#{Markdown.lib}'\n"
      out << "     ====================================================================== -->\n"
      out << content
      out.flush
      out.close

    end # method create_doc


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
        logger.debug "File.exists? #{dirname}/#{basename}#{e}"
        return "#{dirname}/#{basename}#{e}" if File.exists?( "#{dirname}/#{basename}#{e}" )
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
    
        cmd.banner = "Usage: markdown [options] name"
    
        cmd.on( '-o', '--output PATH', 'Output Path' ) { |path| opts.output_path = path }

        # todo: find different letter for debug trace switch (use v for version?)
        cmd.on( "-v", "--verbose", "Show debug trace" )  do
           logger.datetime_format = "%H:%H:%S"
           logger.level = Logger::DEBUG
        end
 
 
        usage =<<EOS

markdown - Lets you convert plain text documents (#{Markdown.extnames.join(', ')}) to hypertext (.html) with your Markdown engine of choice (#{Markdown.lib}).

#{cmd.help}

Examples:
  markdown                   # Process all documents in working folder (that is, .)
  markdown ruby_tut          # Process document or folder using Markdown
  markdown ruby_tut.text     # Process document using Markdown
  markdown -o site ruby_tut  # Output documents to site folder

Further information:
  http://geraldb.github.com/markdown
  
EOS

        cmd.on_tail( "-h", "--help", "Show this message" ) do
           puts usage
           exit
        end
      end

      opt.parse!( args )
  
      puts Markdown.banner
      
      # force loading of config
      Markdown.lib
      
      logger.debug "args.length: #{args.length}"
      logger.debug "args: >#{args.join(',')}<"
      
      # if no file args given; default to working folder (that is, .)
      args = ['.'] if args.length == 0

      args.each do |arg|
        files = find_files( arg )
        files.each do |file|
          create_doc( file )
        end
      end
      
      puts "Done."
      
    end   # method run 
    
  end # class Gen

end # module Markdown