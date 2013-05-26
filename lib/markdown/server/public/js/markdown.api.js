

var markdown_apis_new = function() {

  function _get_dingus( api_url, api_params, handle_html )
  {
    var api_params_str = $.param( api_params );
    api_params_str += '&callback=?'  // NB: add callback for jquery jsonp; NB: need to append as string to avoid encoding of =?

    $.getJSON( api_url, api_params_str, function( data ) {
      handle_html( data.html );    // NB: assumes response { 'html': 'markup here' }
    });
  }

  function _get_dingus_via_proxy( api_url, api_params, handle_html )
  {
    api_params.url = api_url;   // add url to params
    var api_proxy_url = 'http://note.herokuapp.com/proxy'

    _get_dingus( api_proxy_url, api_params, handle_html );
  }

  function _ruby_w_lib( text, lib, handle_html )
  {
    var api_params = {
      text: text,
      lib:  lib
    }
    var api_url = 'http://note.herokuapp.com/markdown/dingus';
 
    _get_dingus( api_url, api_params, handle_html );
  }


  function ruby( text, handle_html )
  {
    var api_params = {
      text: text
    }
    var api_url = 'http://note.herokuapp.com/markdown/dingus';
 
    _get_dingus( api_url, api_params, handle_html );
  }

  function pandoc( text, handle_html )
  {
    // NB: note jsonp enabled - no cross domain request possible; use proxy server or similar
    //   todo: find other service
    var api_params = {
      text: text
    }
    var api_url = 'http://johnmacfarlane.net/cgi-bin/pandoc-dingus'

    _get_dingus_via_proxy( api_url, api_params, handle_html );
  }


  function kramdown( text, handle_html )
  {
     _ruby_w_lib( text, 'kramdown', handle_html );
  }

  function maruku( text, handle_html )
  {
     _ruby_w_lib( text, 'maruku', handle_html );
  }

  function redcarpet( text, handle_html )
  {
     _ruby_w_lib( text, 'redcarpet', handle_html );
  }

  function bluecloth( text, handle_html )
  {
     _ruby_w_lib( text, 'bluecloth', handle_html );
  }

  return {
    ruby:           ruby,
    ruby_kramdown:  kramdown,
    ruby_maruku:    maruku,
    ruby_redcarpet: redcarpet,
    ruby_bluecloth: bluecloth,
    pandoc:         pandoc
  }
} // fn makrdown_apis_new



var markdown_apis = markdown_apis_new();

////////////////
// use like
//
//   markdown_apis.ruby( text, success );
//   markdown_apis.ruby_kramdown( text, success );
//   mardkown_apis.pandoc( text, success );
//   etc.

