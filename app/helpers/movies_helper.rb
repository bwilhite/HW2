module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

#all the helper methods below written for homework2

  #added helper methods (aka secret police/gods of all that is rails)
  def was_highlighted?(column)
  	if @ordered_by==column
      'hilite'
    else
      ''
    end
  end

  def was_checked?(rating)
    @checked_ratings.include? rating unless !@checked_ratings
  end

  #hashtag abstraction
  def create_order_params(column)
  	{order_by: column, ratings: @checked_ratings}
  end
end
