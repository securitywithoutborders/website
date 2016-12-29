###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Internationalization
activate :i18n, :mount_at_root => false

# Easy
activate :autoprefixer

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def home_url
    "/#{I18n.locale}"
  end
  def contact_form_url
    "//localhost:5000/#{I18n.locale}/contact/form"
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

  # Minify Javascript on build
  # activate :minify_javascript
end
