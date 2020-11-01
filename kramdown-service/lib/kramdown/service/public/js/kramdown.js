

var kramdown_new = function( opts ) {

  var settings;  // NB: defaults + opts merged => settings
    
  var defaults = {
    api_url: 'http://trykramdown.herokuapp.com/markdown'
  }


  function _debug( msg )
  {
      if(window.console && window.console.log )
        window.console.log( "[debug] " + msg );
  }


  function _init( opts ) {
     settings = $.extend( {}, defaults, opts );    
  }

  _init( opts );

   
  function _convert( text, more_params, handler )
  {
    var params = $.extend( { text: text }, more_params );  // merge in more params; use text for required param
    
    $.get( settings.api_url, params, function( data ) {
      handler( data ); 
    });
  }
  
  function convert_to_html( text, handler ) {
    // note: make gfm (github-flavored markdown) the default parser
    _convert( text, { to: 'html' }, handler );
  }

  function convert_to_html_with_syntax_highlighter( text, handler ) {
    // note: make gfm (github-flavored markdown) the default parser
    _convert( text, { to: 'html', syntax_highlighter: 'rouge' }, handler );
  }

  function convert_to_html_with_classic( text, handler ) {
    // note: use "classic" "standard" kramdown parser/reader
    _convert( text, { to: 'html', input: 'classic' }, handler );
  }


  
  function convert_to_latex( text, handler ) {
    _convert( text, { to: 'latex' }, handler );
  }
  
  return {
    convert_to_html:  convert_to_html,
    convert_to_html_with_syntax_highlighter: convert_to_html_with_syntax_highlighter,
    convert_to_html_with_classic: convert_to_html_with_classic,
    convert_to_latex: convert_to_latex
  }

} // fn kramdown_new

