require 'nokogiri'
require 'pry'
require 'open-uri'
require 'rb-readline'
require './constants/tonality.rb'
require './web_scraper.rb'

class GetSongs
  def initialize
    @uri = URI("http://www.ultimate-guitar.com/explore")
    @web_scraper = WebScraper.new
  end

  def get_daily_list
    params = { "type[]" => "Chords" }
    file_name = "daily_song_list"
    get_song_list(params, file_name)
  end

  def get_list
    params = { order: "hitstotal_desc", "type[]" => "Chords" }
    file_name = "song_list"
    get_song_list(params, file_name)
  end

  def get_key_list
    TONALITY.each_with_index do |tonality, index|
      next if tonality.nil?
      params = { "tonality[]" => index, "type[]" => "Chords" }
      file_name = "song_list_by_key/#{tonality}"
      get_song_list(params, file_name)
    end
  end

private
  def get_song_list(params, file_name)
    pages = get_number_of_pages(params)

    File.open("songs/#{file_name}.txt", "w") do |file|
      (1..pages).map do |page_number|
        Thread.new do
          params[:page] = page_number
          @uri.query = URI.encode_www_form(params)
          raw_index_page = raw_song_page = @web_scraper.get_raw_page(@uri)

          main_hash = process_raw_page(raw_index_page)
          song_list = main_hash["data"]["data"]["tabs"]

          song_list.each do |song|
            file.puts song["tab_url"]
          end
        end
      end.each{ |t| t.join }
    end
  end

  def get_number_of_pages(params)
    @uri.query = URI.encode_www_form(params)
    raw_index_page = Nokogiri::HTML(open(@uri, 'User-Agent' => 'firefox'))
    main_hash = process_raw_page(raw_index_page)
    return main_hash["data"]["pagination"]["pages"]
  end

  def process_raw_page(raw_page)
    script = raw_page.xpath("//script")[12].content
    script[/^.*window\.UGAPP\.store\.page\s=\s/] = ''
    script[/window\.UGAPP\.store\.i18n\s=\s\{\};/] = ''
    script.strip!
    script.chop!
    JSON.parse(script)
  end
end
# Nokogiri::HTML(open(URI("http://tabs.ultimate-guitar.com/tab/elton_john/goodbye_yellow_brick_road_chords_10735"), 'User-Agent' => 'firefox'))

GetSongs.new.get_daily_list

