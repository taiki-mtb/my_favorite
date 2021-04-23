class StagesController < ApplicationController
  before_action :logged_in_user, except: :show

  def new
    @stage = Stage.new
    @artist = @stage.artists.build
  end

  def show
    @stage = Stage.find(params[:id])
    @stage_tags = @stage.tags
    @stage_lists = @stage.lists
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @stages = @tag.stages.all
  end

  def list
    @list_all = List.all
    @list = List.find(params[:list_id])
    @stages = @list.stages.all
  end

  def create
    @stage = Stage.new(stage_params.slice(:title, :info, :from_date, :until_date, :place, images: []))
    tag_list = params[:stage][:tag_name].split(',')
    list_all = params[:stage][:list_name].split(',')
    if @stage.save
      @stage.save_tag(tag_list)
      @stage.save_list(list_all)
      @artist = Artist.find_or_create_by(name: stage_params[:name])
      @stage.artists << @artist
      flash[:success] = "新しいstageが登録されました"
      redirect_to @stage
    else
      render 'stages/new'
    end
  end

  def edit
    @stage = Stage.find(params[:id])
    @tag_list = @stage.tags.pluck(:tag_name).join(',')
    @list_all = @stage.lists.pluck(:tag_name).join(',')
  end

  def update
    @stage = Stage.find(params[:id])
    tag_list = params[:stage][:tag_name].split(',')
    list_all = params[:stage][:list_name].split(',')
    if @stage.update_attributes(stage_params)
      @stage.save_tag(tag_list)
      @stage.save_list(list_all)
      flash[:success] = "更新されました"
      redirect_to @stage
    end
  end

  def destroy
    @stage = Stage.find(params[:id])
    if @stage.destroy
      flash[:success] = "削除されました"
      redirect_to root_url
    else
      flash[:danger] = "管理人しか削除できません"
      redirect_to @stage
    end
  end

  private

    def stage_params
      params.require(:stage).permit(:title, :info, :from_date, :until_date, :place, images: [])
    end
end
