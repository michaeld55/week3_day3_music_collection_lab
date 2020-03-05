class Artist

  require_relative('../db/sql_runner.rb')

  attr_accessor :name, :id

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO artists(
      name
      ) VALUES (
        $1
        )
        RETURNING id"
        values = [@name]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def find_album
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map { |album| Album.new(album)}
  end

  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find_all
    sql = "SELECT * FROM artists"
    results = SqlRunner.run(sql)
    return results.map { |result| Artist.new(result)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Artist.new(result)
  end

end
