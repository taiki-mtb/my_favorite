class TagsController < ApplicationController
  def index
    @tag = Tag.all
    @tag_all_contents = Dance.all | Music.all | Stage.all
  end

  def show
    @tag = Tag.find(params[:id])
    @tag_contents = @tag.musics.all | @tag.dances.all | @tag.stages.all
  end
end
