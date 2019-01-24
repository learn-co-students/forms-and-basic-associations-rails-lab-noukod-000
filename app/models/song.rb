class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  #methods created in this label
  def genre_name= name
    self.genre = Genre.find_or_create_by name: name
  end

  def genre_name
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
