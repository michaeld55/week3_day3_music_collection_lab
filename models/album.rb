class Album

  attr_accessor :id, :title, :genre
  attr_reader :artist_id

  require_relative('../db/sql_runner.rb')

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i

  end

  def save
    sql = "INSERT INTO albums(
    title, genre, artist_id
    ) values (
      $1, $2, $3
      ) RETURNING id"
      values = [@title, @genre, @artist_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def find_artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@id]
    artists = SqlRunner.run(sql, values)
    return artists.map { |artist| Artist.new(artist)}
  end

  def update
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.find_all
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql)
    return results.map { |result| Album.new(result)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Album.new(result)
  end



end
