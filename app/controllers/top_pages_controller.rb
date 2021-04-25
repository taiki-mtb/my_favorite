class TopPagesController < ApplicationController

  def top
    @movie = Dance.all | Music.all
    @random_movie = @movie.sample
    @all_contents = Dance.all | Music.all | Stage.all
  end
end
