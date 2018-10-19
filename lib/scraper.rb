require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    srape_url = Nokogiri::HTML(open(index_url))
    srape_url.css(".student-card a").map do |html_student|
      {name: html_student.css("h4").text, location: html_student.css("p").text, profile_url: html_student.attribute("href").value}
    end
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    student, reseaus = {}, [:linkedin, :twitter, :github]
    Nokogiri::HTML(open(profile_url)).tap do |nokogiri|
      links = nokogiri.css(".social-icon-container a").map {|a| a.attribute("href").value}

      links.each do |link|
        reseaus.each do |reseau|
          if link.include?(reseau.to_s)
            student[reseau] = link
          end
        end
        student[:blog] = link if !student.values.include?(link)
      end

      student[:profile_quote] = nokogiri.css(".profile-quote").text if nokogiri.css(".profile-quote")
      student[:bio] = nokogiri.css("div.bio-content.content-holder div.description-holder p").text if nokogiri.css("div.bio-content.content-holder div.description-holder p")

    end
    # binding.pry
    student
  end

end
# binding.pry
# Scraper.scrape_index_page './fixtures/student-site/index.html'
# Scraper.scrape_profile_page "./fixtures/student-site/students/joe-burgess.html"
