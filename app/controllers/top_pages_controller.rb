class TopPagesController < ApplicationController
  def top
    @movie = Dance.all | Music.all
    @random_movie = @movie.pluck(:youtube_url).sample
    @all_contents = Dance.all | Music.all | Stage.all
  end
end
