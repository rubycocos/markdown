# Notes

## Alternatives

Online Kramdown Editor by Daniel Perez Alvarez (aka unindented)

- Live @ Heroku [kramdown.herokuapp.com](http://kramdown.herokuapp.com)
- Source @ GitHub [unindented/online-kramdown-sinatra](https://github.com/unindented/online-kramdown-sinatra)



## kramdown Options

doc = Kramdown::Document.new( '<text here>' )
pp doc.options

```
{:template=>"",
 :auto_ids=>true,
 :auto_id_stripping=>false,
 :auto_id_prefix=>"",
 :transliterated_header_ids=>false,
 :parse_block_html=>false,
 :parse_span_html=>true,
 :html_to_native=>false,
 :link_defs=>{},
 :footnote_nr=>1,
 :enable_coderay=>true,
 :coderay_wrap=>:div,
 :coderay_line_numbers=>:inline,
 :coderay_line_number_start=>1,
 :coderay_tab_width=>8,
 :coderay_bold_every=>10,
 :coderay_css=>:style,
 :coderay_default_lang=>nil,
 :entity_output=>:as_char,
 :toc_levels=>[1, 2, 3, 4, 5, 6],
 :line_width=>72,
 :latex_headers=>
  ["section",
   "subsection",
   "subsubsection",
   "paragraph",
   "subparagraph",
   "subparagraph"],
 :smart_quotes=>["lsquo", "rsquo", "ldquo", "rdquo"],
 :remove_block_html_tags=>true,
 :remove_span_html_tags=>false,
 :header_offset=>0,
 :hard_wrap=>true,
 :syntax_highlighter=>:coderay,
 :syntax_highlighter_opts=>{},
 :math_engine=>:mathjax,
 :math_engine_opts=>{},
 :footnote_backlink=>"&#8617;"}
```

doc = Kramdown::Document.new( '<text here>', input: 'GFM', hard_wrap: false, syntax_highlighter: 'rouge' )
pp doc.options

```
{:template=>"",
 :auto_ids=>true,
 :auto_id_stripping=>false,
 :auto_id_prefix=>"",
 :transliterated_header_ids=>false,
 :parse_block_html=>false,
 :parse_span_html=>true,
 :html_to_native=>false,
 :link_defs=>{},
 :footnote_nr=>1,
 :enable_coderay=>true,
 :coderay_wrap=>:div,
 :coderay_line_numbers=>:inline,
 :coderay_line_number_start=>1,
 :coderay_tab_width=>8,
 :coderay_bold_every=>10,
 :coderay_css=>:style,
 :coderay_default_lang=>nil,
 :entity_output=>:as_char,
 :toc_levels=>[1, 2, 3, 4, 5, 6],
 :line_width=>72,
 :latex_headers=>
  ["section",
   "subsection",
   "subsubsection",
   "paragraph",
   "subparagraph",
   "subparagraph"],
 :smart_quotes=>["lsquo", "rsquo", "ldquo", "rdquo"],
 :remove_block_html_tags=>true,
 :remove_span_html_tags=>false,
 :header_offset=>0,
 :hard_wrap=>false,
 :syntax_highlighter=>:rouge,
 :syntax_highlighter_opts=>{},
 :math_engine=>:mathjax,
 :math_engine_opts=>{},
 :footnote_backlink=>"&#8617;",
 :input=>"GFM"}
```
