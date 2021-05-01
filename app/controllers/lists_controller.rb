class ListsController < ApplicationController

  def index
    @list = List.all
  end

  def show
    @list = List.find(params[:id])
    @contents = @list.musics.all | @list.dances.all | @list.stages.all
  end

  def destroy
    @list = List.find(params[:id])
    if logged_in?
      @list.destroy
      flash[:success] = "削除されました"
      redirect_to root_url
    else
      flash[:danger] = "管理人しか削除できません"
      redirect_to @list
    end
  end

end
