class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name= name
    #since the song has no genre, we have to create it
    self.genre = Genre.find_or_create_by name: name
  end

  def genre_name
    #if the song has a genre return the genre's name else return nil
    genre ? genre.name : nil
  end

  def artist_name= name
    self.artist = Artist.find_or_create_by name: name
  end

  def artist_name
    artist ? artist.name : nil
  end

  def note_contents= contents
    contents.each do |c|
      self.notes << Note.find_or_create_by(content: c) unless c.empty?
    end
  end

  def note_contents
    notes.map do |n|
      n.content
    end
  end
end
