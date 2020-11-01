# kramdown-service gem - kramdown HTTP JSON API service (convert markdown to HTML or LaTeX)

* home  :: [github.com/writekit/kramdown-service](https://github.com/writekit/kramdown-service)
* bugs  :: [github.com/writekit/kramdown-service/issues](https://github.com/writekit/kramdown-service/issues)
* gem   :: [rubygems.org/gems/kramdown-service](https://rubygems.org/gems/kramdown-service)
* rdoc  :: [rubydoc.info/gems/kramdown-service](http://rubydoc.info/gems/kramdown-service)


## Live Version

Try the `markdown` HTTP (JSON) API running
on Heroku [`trykramdown.herokuapp.com`](http://trykramdown.herokuapp.com).

Note: If you see an Application Error on Heroku. Sorry. It means "**Free app running time quota exhausted**".
Please, check back and retry on the first day of the next upcoming month (that starts a new dyna hours quota) or use `$ kramup` to run the service on your local machine). Thanks.




## Start Your Own Local Version / Service

To start your own local version on your own machine use the bundled command line tool called `kramup`.

Step 0 - Install the gem e.g.

    $ gem install kramdown-service

Step 1 - Start the server / service e.g.

    $ kramup

Step 2 - Open up the editor page in your browser e.g. use `http://localhost:4567`.

That's it.


## Usage - Web Service / HTTP (JSON) API - `GET /markdown`


Example 1 - Converting to Hypertext (HTML):

    GET /markdown?text=Hello+World!

    <p>Hello World!</p>


Example 2 - Converting to LaTeX:

    GET /markdown?text=Hello+World!&to=latex

    Hello World!




## License

The `kramdown-service` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[wwwmake forum/mailing list](http://groups.google.com/group/wwwmake).
Thanks!
