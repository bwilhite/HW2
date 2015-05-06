class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    #HW2 added lines to sort by order_by and to filter by the selected ratings
    @all_ratings = Movie.get_ratings
    #moved ordered by out to abstract a bit, not sure if that was the right decision
    @ordered_by = params[:order_by] if params.has_key? 'order_by'

    #rating filter happens first
    if params.has_key? 'ratings'
      @checked_ratings = params[:ratings]

      #posibility of being checked, was outside with two different if/elsif, but that seemed redundant, not sure if I've tested all the possibilities though
      if @ordered_by
        #using both in one--not sure this is kosher....
        @movies = Movie.find_all_by_rating(@checked_ratings, :order => "#{@ordered_by} asc")
      else
        @movies = Movie.find_all_by_rating(@checked_ratings)
      end
    elsif @ordered_by
      @movies = Movie.all(:order => "#{@ordered_by} asc")
    else
      @movies = Movie.all
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
