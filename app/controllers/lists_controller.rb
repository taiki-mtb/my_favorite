class ListsController < ApplicationController

  def index
    @list = List.all
    @all_contents = Dance.all | Music.all | Stage.all
  end

  def show
    @list = List.find(params[:id])
    @contents = @list.musics.all | @list.dances.all | @list.stages.all
  end


#   def show
#     @dance = Dance.find(params[:id])
#     @dance_tags = @dance.tags   
#   end

#   def search
#     @tag_list = Tag.all
#     @tag = Tag.find(params[:tag_id])
#     @dances = @tag.dances.all
#   end

#   def create
#     @list = List.new(list_params)
#     if @list.save
#       flash[:success] = "新しいlistが登録されました"
#       redirect_to @list
#     else
#       render 'lists/new'
#     end
#   end

#   private

#     def list_params
#       params.require(:list).permit(:list_name)
#     end
end
