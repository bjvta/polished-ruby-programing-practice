# the source code is taking from https://github.com/PacktPublishing/Polished-Ruby-Programming/tree/main

# Array
# If we need to iterate, or using a collection or a stack, we can use arrays

[[:home,1], [:house, 2], [:store, 3]].each do |sym, i|
  # ...
end

# Hash
# If we need a mapping of one or more objects, we need a hash
{home: 1, house: 2, store: 3}.each do |sym, i|
  #....
end

# Set
# If we have a large objects and see whether a given object is contained in it


# Create the database in an array

album_infos = 100.times.flat_map do |i|
  10.times.map do |j|
    ["Album #{i}", j, "Artist #{j}"]
  end
end

# Print the whole data
# print(album_infos)

# The first apprach to fill the data in others

album_artists = {}
album_track_artists = {}
album_infos.each do |album, track, artist|
  (album_artists[album] ||= []) << artist
  (album_track_artists[[album, track]] ||= []) << artist
end
album_artists.each_value(&:uniq!)

# print(album_artists)
# print(album_track_artists)

# With this approach with can look up value (artist) with this

lookup = ->(album, track=nil) do
  if track
    album_track_artists[[album, track]]
  else
    album_artists[album]
  end
end

# Examples
# example1 = lookup.call("Album 1")
# print(example1)
# example2 = lookup.call("Album 3", 3)
# print(example2)



## Second way to fill the data, only with hashes

albums = {}
album_infos.each do |album, track, artist|
  ((albums[album] ||= {}) [track] ||= []) << artist
end

# so the way to lookup will be

lookup= -> (album, track=nil) do
  if track
    albums.dig(album, track)
  else
    a = albums[album].each_value.to_a
    a.flatten!
    a.uniq!
  end
end

# example3 = lookup.call("Album 4")
# print(example3)
# example4 = lookup.call("Album 5", 3)
# print(example4)



## Third approach

albums = {}

album_infos.each do |album, track, artist|
  album_array = albums[album] ||= [[]]
  album_array[0] << artist
  (album_array[track] ||= []) << artist
end
print(albums)
albums.each_value do |array|
  array[0].uniq!
end

lookup = -> (album, track=0) do
  albums.dig(album, track)
end

# example5 = lookup.call("Album 9", 8)
# print(example5)
# example6 = lookup.call("Album 10")
# print(example6)


