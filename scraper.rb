# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
root = "http://informatika.ft.unpkediri.ac.id"
page = agent.get("#{root}/?hal=arsip&kategori=Pengumuman")
#
# # Find somehing on the page using css selectors
# p page.at('div.content')
articles = page.search '.maincontent li'
#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
articles.each do |article|
  ScraperWiki.save_sqlite [:link], {
    title: article.at('a').text,
    link: root + '/' + article.at('a')[:href],
    date: Date.parse(article.at('small').text.split('|')[1])
  }
end
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
