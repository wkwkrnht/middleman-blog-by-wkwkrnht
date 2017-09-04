require 'ansi/code'
require 'slim'

Time.zone = 'Tokyo'

set :layout, :_auto_layout
set :layouts_dir, 'template'
set :images_dir, 'img'
set :css_dir, 'style'
set :js_dir, 'script'

# set engines, template->slim, markdown->kramdown
set :slim, :layout_engine => :slim, :format => :html
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true

activate :similar
activate :automatic_image_sizes
activate :syntax, :line_numbers => true

activate :blog do |blog|
    blog.default_extension = '.md'
    blog.sources = 'blog/articles/:title.html'
    blog.permalink = ':year/:title.html'
    blog.layout = 'template/article'
    blog.tag_template = 'asset/tag'
    blog.calendar_template = 'asset/calender'
end

activate :sitemap_ping do |config|
    config.host = 'https://middleman-by-wkwkrnht.netlify.com' # (required) Host of your website
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
        }
    ],
    :sitemap => 'https://middleman-by-wkwkrnht.netlify.com/sitemap.xml'

configure :build do
    activate :minify_html
    activate :gzip
    activate :minify_css
    activate :minify_javascript
    activate :cache_buster
end