# markdown.api.js

markdown HTTP JSON API  (also known as dingus)


Use "standard (default)" markdown library (engine/processor):

```
GET /dingus?text=Hello+World
```

or use lib parameter to select 

```
GET /dingus?lib=kramdown&text=Hello+World
```

results in:

```json
{
name: "kramdown",
html: "<p>Hello World</p> ",
version: "1.5.6"
}
```




## License

The `markdown.api.js` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.

## Questions? Comments?

Send them along to the [Markdown Mailing List](http://six.pairlist.net/mailman/listinfo/markdown-discuss).
Thanks!
