require 'nokogiri'
require 'pry'
require 'open-uri'
require 'rb-readline'
require './constants/tonality.rb'

class GetChords
  def initialize(write_semaphore: Mutex.new)
    @write_semaphore = write_semaphore
  end

  def get_key_list_chords
    TONALITY.each do |tonality|
      next if tonality.nil?
      puts "<------ START TONALITY: #{tonality} --------->"
      songs = get_song_content("song_content_by_key/#{tonality}")
      chords_to_file(songs, "chords_by_key/#{tonality}")
      puts "\n<------ END TONALITY: #{tonality} --------->"
    end
  end

  def get_specific_key_list_chords(indexes)
    indexes.each do |index|
      tonality = TONALITY[index]
      next if tonality.nil?
      puts "<------ START TONALITY: #{tonality} --------->"
      songs = get_song_content("song_content_by_key/#{tonality}")
      chords_to_file(songs, "chords_by_key/#{tonality}")
      puts "\n<------ END TONALITY: #{tonality} --------->"
    end
  end

private
  def get_song_content(file_name)
    File.open("song_content/#{file_name}.txt", "r").map { |song| song.strip! }
  end

  def chords_to_file(songs, file_name)
    File.open("chords/#{file_name}.txt", "w") do |file|
      songs.map do |song|
        # Thread.new do
          data = JSON.parse(song)["data"]
          title = get_title(data)
          chords = get_chords(data)

          @write_semaphore.synchronize do
            file.puts "#{title}: #{chords}"
          end
        end
      # end.each{ |t| t.join }
    end
  end

  def get_chords(data)
    content = data["tab_view"]["wiki_tab"]["content"]
    chords = content.scan(/\[ch\][A-G].?\w*\[\/ch\]/)
    chords.map do |chord|
      chord.gsub(/\[\/?ch\]/, "")
    end.join(", ")
  end

  def get_title(data)
    data["tab"]["song_name"]
  end
end

gc = GetChords.new
gc.get_key_list_chords
# gc.get_specific_key_list_chords([1])

