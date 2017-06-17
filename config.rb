require 'lib/uuid'
require 'ansi/code'
require 'slim'

Dotenv.load
Time.zone = 'Tokyo'

activate :automatic_image_sizes
activate :syntax, :line_numbers => true

set :layout, :_auto_layout
set :layouts_dir, 'template'
set :helpers_dir, 'helper'
set :locales_dir, 'locale'
set :images_dir, 'img'
set :css_dir, 'style'
set :js_dir, 'script'

# set engines, template->slim, markdown->kramdown
set :slim, :layout_engine => :slim, :format => :html
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings
activate :blog do |blog|
    blog.prefix = 'blog'
    blog.default_extension = '.md'
    blog.sources = 'articles/:title.html'
    blog.permalink = ':title.html'
    blog.layout = 'template/article'
    blog.tag_template = 'blog/template/tag.html'
    blog.calendar_template = 'blog/template/calender.html'
    blog.name = 'RT狂の思考ログ'
    blog.summary_separator = /\(READMORE\)/
    blog.paginate = false
end

activate :search do |search|
    search.resources = ['index.html', 'articles/']
    search.language = 'ja'

    # Search fields are indexed by default, but not stored. Storing takes up
    # space, so we should only store what is needed to render search results: the
    # title, the date, and the URL. We'll index the content but no store it.
    # Additionally, we apply a "boost" to the title and content fields.
    search.fields = {
        title:   {boost: 100, store: true, required: true},
        date:    {index: false, store: true},
        content: {boost: 50},
        url:     {index: false, store: true}
    }
end

activate :sitemap_ping do |config|
    config.host         = 'http://example.com' # (required) Host of your website
end

activate :robots,
    :rules => [
        {
            :user_agent => 'Googlebot',
            :allow => %w(/),
            :disallow => %w(404.html)
        },
        {
            :user_agent => 'Googlebot-Image',
            :allow => %w(/),
            :disallow => %w(404.html)
        },
        {
            :user_agent => '*',
            :allow => %w(/)
        }
    ],
    :sitemap => "http://example.com/sitemap.xml"

configure :build do
    activate :minify_html
    activate :gzip
    activate :minify_css
    activate :minify_javascript
    activate :cache_buster
    activate :relative_assets
    activate :similar
end