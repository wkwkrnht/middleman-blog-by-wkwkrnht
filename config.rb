require 'lib/uuid'
require 'ansi/code'
require 'slim'

Dotenv.load
Time.zone = 'Tokyo'

activate :automatic_image_sizes
activate :syntax, :line_numbers => true

set :layout, :_auto_layout
set :layouts_dir, 'template'
set :helpers_dir, 'helpers'
set :locales_dir, 'locale'
set :images_dir, 'img'
set :css_dir, 'style'
set :js_dir, 'script'

# set engines, template->slim, markdown->kramdown
set :slim, :layout_engine => :slim, :format => :html5
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true

# Create an RFC4122 UUID http://www.ietf.org/rfc/rfc4122.txt
set :uuid, UUID.create_sha1('malik.pro', UUID::NameSpace_URL)

 # Blog settings - GLOBAL
activate :blog do |blog|
    blog.prefix = ''
    blog.sources = 'articles/:title.html'
    blog.default_extension = '.md'
    blog.permalink = prefix+':title.html'
    blog.year_link = prefix+':year.html'
    blog.month_link = prefix+':year/:month.html'
    blog.day_link = prefix+':year/:month/:day.html'
    blog.taglink = prefix+':tag.html'
    blog.layout = 'layout/article.slim'
    blog.tag_template = "tag."+name+".slim"
    blog.calendar_template = "calendar."+name+".slim"
    blog.name = name
    blog.summary_separator = /\(READMORE\)/
    blog.paginate = false
end

activate :search do |search|
    search.resources = ['/']

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

# Ignore Blog Templates
ignore "/tag.slim"
ignore "/calendar.slim"

page "/sitemap.xml", :layout => "sitemap.xml"


configure :development do
  activate :google_analytics do |ga|
    ga.tracking_id = false
  end
end


# Build-specific configuration
configure :build do
  # activate :minify_html
    activate :gzip
    activate :minify_css
    activate :minify_javascript
    activate :cache_buster
    activate :relative_assets
    activate :google_analytics do |ga|
        ga.tracking_id = false
    end
end