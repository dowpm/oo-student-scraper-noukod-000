require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    srape_url = nokogiri::HTML(open(index_url))
    scrape_url.css(".student-card")
    binding.pry 
  end

  def self.scrape_profile_page(profile_url)

  end

end
