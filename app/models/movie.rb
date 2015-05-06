class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  #written for homework 2
  def Movie.get_ratings
		ratings = []
		self.select(:rating).group(:rating).each do |r|
			ratings.push(r.rating)
		end
		return ratings
	end
end
