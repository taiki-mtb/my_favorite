class StagesController < ApplicationController
  before_action :logged_in_user, except: :show

  def new
    @stage = Stage.new
  end

  def show
    @stage = Stage.find(params[:id])
  end

  def create
    @stage = Stage.new(stage_params)
    if @stage.save
      flash[:success] = "新しいstageが登録されました"
      redirect_to @stage
    else
      render 'stages/new'
    end
  end

  def edit
  	@stage = Stage.find(params[:id])
  end

  def update
  	@stage = Stage.find(params[:id])
  	if @stage.update_attributes(stage_params)
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
      params.require(:stage).permit(:name, :info, :from_date, :until_date, :place, images: [])
    end

end
