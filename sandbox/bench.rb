require 'benchmark'
require 'pathname'


require 'rubygems'

require 'bluecloth'
require 'maruku'
require 'kramdown'
require 'redcarpet'
require 'rdiscount'

ITERATIONS = 200

## todo: use longer sample text

TEST_FILE = Pathname.new( __FILE__ ).dirname + 'rest.text'
TEST_DATA = TEST_FILE.read
TEST_DATA.freeze


puts "Markdown -> Hypertext, #{ITERATIONS} iterations (using document >#{TEST_FILE}<, #{TEST_DATA.length} bytes)"

class KramdownWrapper
  VERSION = Kramdown::VERSION

  def self.name
    'Kramdown'
  end

  def initialize( text )
    @text = text
  end
  
  def to_html
    Kramdown::Document.new( @text ).to_html
  end
end


class RedcarpetWrapper
  VERSION = Redcarpet::VERSION

  def self.name
    'Redcarpet'
  end

  def initialize( text )
    @text = text
  end
  
  def to_html
    engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    engine.render( @text )
  end
end



ENGINES = [
    BlueCloth,
    Maruku,
    RDiscount,
    KramdownWrapper,
    RedcarpetWrapper ]


Benchmark.bmbm do |bench|
  ENGINES.each do |engine|
    heading = "%s (%s)" % [ engine.name, engine.const_get(:VERSION) ]
    bench.report( heading ) { ITERATIONS.times {engine.new(TEST_DATA).to_html} }
  end
end

__END__

Markdown -> Hypertext, 200 iterations (using document >sandbox/rest.text<, 2880 bytes)

Rehearsal -----------------------------------------------------
BlueCloth (1.0.1)   1.466000   0.000000   1.466000 (  1.462000)
Maruku (3.1.7.3)    5.242000   0.016000   5.258000 (  5.290000)
RDiscount (1.6.8)   0.078000   0.000000   0.078000 (  0.072000)
Kramdown (0.13.7)   2.699000   0.327000   3.026000 (  3.032000)
Redcarpet (2.1.1)   0.015000   0.000000   0.015000 (  0.019000)
-------------------------------------------- total: 9.843000sec

                        user     system      total        real
BlueCloth (1.0.1)   1.529000   0.000000   1.529000 (  1.553000)
Maruku (3.1.7.3)    5.772000   0.000000   5.772000 (  5.780000)
RDiscount (1.6.8)   0.078000   0.000000   0.078000 (  0.072000)
Kramdown (0.13.7)   2.621000   0.000000   2.621000 (  2.611000)
Redcarpet (2.1.1)   0.015000   0.000000   0.015000 (  0.018000)