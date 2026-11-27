require "json"
require "open-uri"

puts "Cleaning the database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

base_url = "https://tmdb.lewagon.com/movie/top_rated"
image_url = "https://image.tmdb.org/t/p/original"
target = 100
page = 1

puts "Fetching top rated movies from TMDB..."
while Movie.count < target && page <= 20
  response = URI.open("#{base_url}?page=#{page}").read
  results = JSON.parse(response)["results"]

  results.each do |movie|
    break if Movie.count >= target
    next if movie["overview"].blank?

    Movie.find_or_create_by!(title: movie["title"]) do |new_movie|
      new_movie.overview = movie["overview"]
      new_movie.poster_url = movie["poster_path"] ? "#{image_url}#{movie["poster_path"]}" : nil
      new_movie.rating = movie["vote_average"].round(1)
    end
  end

  page += 1
end

puts "Done! #{Movie.count} movies created."
