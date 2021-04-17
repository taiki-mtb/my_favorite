class DancesController < ApplicationController
  before_action :logged_in_user, except: :show

  def new
    @dance = Dance.new
  end

  def show
    @dance = Dance.find(params[:id])
    @dance_tags = @dance.tags   
  end

  def create
    @dance = Dance.new(dance_params)
    tag_list = params[:dance][:tag_name].split(',')
    if @dance.save
      @dance.save_tag(tag_list)
      flash[:success] = "新しいdanceが登録されました"
      redirect_to @dance
    else
      render 'dances/new'
    end
  end

  def edit
    @dance = Dance.find(params[:id])
    @tag_list = @dance.tags.pluck(:tag_name).join(',')
  end

  def update
    @dance = Dance.find(params[:id])
    tag_list = params[:dance][:tag_name].split(',')
    if @dance.update_attributes(dance_params)
      @dance.save_tag(tag_list)
      flash[:success] = "更新されました"
      redirect_to @dance
    end
  end

  def destroy
    @dance = Dance.find(params[:id])
    if logged_in?
      @dance.destroy
      flash[:success] = "削除されました"
      redirect_to root_url
    else
      flash[:danger] = "管理人しか削除できません"
      redirect_to @dance
    end
  end

  private

    def dance_params
      params.require(:dance).permit(:name, :info, :date, :youtube_url)
    end
end
