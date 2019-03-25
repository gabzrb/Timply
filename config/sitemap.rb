require 'rubygems'
require 'sitemap_generator'
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://timply.fr"
SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
aws_access_key_id: ENV["S3_ACCESS_KEY"],
aws_secret_access_key: ENV["S3_SECRET_KEY"],
fog_provider: 'AWS',
fog_directory: ENV["S3_BUCKET_NAME"],

)

SitemapGenerator::Sitemap.create do
      add '/home', :changefreq => 'daily', :priority => 0.9
  add '/contact_us', :changefreq => 'weekly'
    end

    add "en/single-page"
    add "nl/single-page"
    add "nl/starters-website"
    add "en/starters-website"
    add "nl/website-op-maat"
    add "en/website-op-maat"
    add "nl/webapplicatie"
    add "en/webapplicatie"
    add "nl/website-analyse"
    add "en/website-analyse"


