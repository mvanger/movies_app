class MoviesController < ApplicationController
  def search
    @searched = Imdb::Search.new(params[:title]).movies[0..14]
    render 'index'
  end

  def index
    @faves = Movie.where(rating: 100)
    @saves = Movie.where('rating < ?', 100)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def details
    @movie = Imdb::Movie.new(params[:id])
  end

  def save
    query = Imdb::Movie.new(params[:id])
    movie = Movie.new
    movie.title = query.title
    movie.year = query.year
    movie.plot = query.plot
    movie.mpaa_rating = query.mpaa_rating
    movie.rating = params[:rating]
    movie.save
    redirect_to '/movies'
  end

  def rating
    movie = Movie.find(params[:id])
    movie.rating += 1
    movie.save
    redirect_to "/movies/#{movie.id}"
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
    redirect_to("/movies")
  end
end