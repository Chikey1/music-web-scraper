require 'nokogiri'
require 'pry'
require 'open-uri'
require 'rb-readline'
require './constants/tonality.rb'
require './web_scraper.rb'

class GetSongContent
  def initialize(crawl_delay: 0, write_semaphore: Mutex.new)
    @web_scraper = WebScraper.new(crawl_delay: crawl_delay)
    @write_semaphore = write_semaphore
  end

  def get_key_list_chords
    TONALITY.each do |tonality|
      next if tonality.nil?
      songs = get_song_list("song_list_by_key/#{tonality}")
      content_to_file(songs, "song_content_by_key/#{tonality}")
    end
  end

  def get_specific_key_list_chords(indexes)
    indexes.each do |index|
      tonality = TONALITY[index]
      puts "<------ START TONALITY: #{tonality} --------->"
      next if tonality.nil?
      songs = get_song_list("song_list_by_key/#{tonality}")
      content_to_file(songs, "song_content_by_key/#{tonality}")
      puts "\n<------ END TONALITY: #{tonality} --------->"
      @web_scraper.reset_counter
    end
  end

private
  def get_song_list(file_name)
    File.open("songs/#{file_name}.txt", "r").map { |song| song.strip! }
  end

  def content_to_file(songs, file_name)
    File.open("song_content/#{file_name}.txt", "w") do |file|
      songs.map do |url|
        Thread.new do
          song = get_song_content(url)

          @write_semaphore.synchronize do
            file.puts song
          end
        end
      end.each{ |t| t.join }
    end
  end

  def get_song_content(url)
    uri = URI(url)
    raw_song_page = @web_scraper.get_raw_page(uri)
    main_tag = raw_song_page.xpath("//script")[12].content

    main_tag[/^.*window\.UGAPP\.store\.page\s=\s/] = ''
    main_tag[/window\.UGAPP\.store\.i18n\s=\s\{\};/] = ''
    main_tag.strip!
    main_tag.chop!
    return main_tag
  end
end

gc = GetSongContent.new()
# gc.get_specific_key_list_chords([27,28,29,30])