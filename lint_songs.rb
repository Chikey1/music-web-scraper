require './constants/tonality.rb'

def check_daily_list_chords
  songs = get_song_list("daily_song_list")
  check_song_list(songs)
end

def check_list_chords
  songs = get_song_list("song_list")
  check_song_list(songs)
end

def check_key_list_chords
  TONALITY.each do |tonality|
    next if tonality.nil?
    songs = get_song_list("song_list_by_key/#{tonality}")
    check_song_list(songs)
  end
end

def get_song_list(file_name)
  File.open("songs/#{file_name}.txt", "r").map { |song| song.strip! }
end

def check_song_list(songs)
  songs.each do |song|
    next if song.start_with?("https://tabs.ultimate-guitar.com/tab")
    puts song
  end
end

check_daily_list_chords
check_list_chords
check_key_list_chords