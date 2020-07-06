###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '*code-of-conduct.html', layout: 'layout-markdown'

page '/resources/*', layout: 'layout-markdown'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true
set :markdown_engine, :redcarpet

# Internationalization
activate :i18n, :mount_at_root => :en

# Easy
activate :autoprefixer
activate :syntax

activate :blog do |blog|

  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"

  # set options on blog
  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files

  # blog.taglink = "tags/{tag}.html"
  blog.layout = "layouts/blog-post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 500
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  blog.calendar_template = "blog/calendar.html"
  blog.sources = "posts/{year}-{month}-{day}-{title}.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
  blog.publish_future_dated = true
end



# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###
page "/feed.xml", layout: false

# Methods defined in the helpers block are available in templates
helpers do
  def home_url
    if I18n.locale.to_s != 'en' then "/#{I18n.locale}/" else "/" end
  end
  def trimmed_locales
    locales_list.each do |locale|
      locale.slice! ".yml"
    end
  end
  def locales_list
    Dir.glob("locales/*.yml").each do |file|
      file.slice! "locales/"
    end
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css
  activate :minify_html

  # Minify Javascript on build
  # activate :minify_javascript

  # Generate favicons
  activate :favicon_maker do |f|
    # template_dir doesn't work in 4.0 as per https://github.com/follmann/middleman-favicon-maker/issues/42
    # f.template_dir  = 'source/images'
    f.icons = {
      # Hack: instead specify directory in filename
      "images/_favicon_template.svg" => [
        # Only generate small icons since the original is of too low
        # quality for higher resolutions.
        { icon: "favicon.png", size: "16x16" },
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
      ]
    }
  end
end
