# See https://github.com/kjvarga/sitemap_generator for information how to configure
settings = YAML.load_file(Rails.root.join("config/settings.yml"))

SitemapGenerator::Sitemap.create(:default_host => settings['host']) do

  Post.published(1,50).each do |post|
    add post_path(post.slug), :lastmod => post.updated_at, :changefreq => 'daily'
  end

  Category.find_each do |category|
    add category_posts_path(category.slug), :lastmod => category.updated_at, :changefreq => 'daily'
  end

  Author.find_each do |author|
    add author_path(author.slug), :lastmod => author.updated_at, :changefreq => 'daily'
  end

  Page.find_each do |page|
    add page_path(page.slug), :lastmod => page.updated_at, :changefreq => 'weekly'
  end
end