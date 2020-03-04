require('pry')
require_relative('../models/artist.rb')
require_relative('../models/album.rb')
require_relative('sql_runner.rb')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' =>"Disturbed"})
artist2 = Artist.new({'name' => 'Dermot Kennedy'})
artist1.save
artist2.save

album1 = Album.new({'title' => 'The Sickeness', 'genre' => 'Heavy Metal', 'artist_id' => artist1.id})
album2 = Album.new({'title' => 'Without Fear', 'genre' => 'Folk/Pop', 'artist_id' => artist2.id})
album1.save
album2.save

# artist1.name = "James Blake"
# artist1.update
#
# album1.title = "Assume Form"
# album1.update





binding.pry
nil
