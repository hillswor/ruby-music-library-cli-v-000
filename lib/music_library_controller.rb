require 'pry'

class MusicLibraryController

  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    new_music_library = MusicImporter.new(@path)
    new_music_library.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = nil
    until input == "exit"
      input = gets
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "play song"
        play_song
      when "list artist"
        list_artist
      when "list genre"
        list_genre
      end
    end
  end

  def list_songs
    alphabetical_song_list = Song.all.sort_by {|song| song.name}
    alphabetical_song_list.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end



  def list_artists
    alphabetical_artist_list = Artist.all.sort_by {|artist| artist.name}
    alphabetical_artist_list.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.each {|genre| puts genre.name}
  end

  def play_song
    song = Song.all[gets.to_i - 1]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def list_artist
    specific_artist = gets
    puts Artist.find_by_name(specific_artist).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

   def list_genre
    specific_genre = gets
    puts Genre.find_by_name(specific_genre).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

end
