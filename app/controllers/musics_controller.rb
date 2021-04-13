class MusicsController < ApplicationController
  before_action :logged_in_user, except: :show

  def new
    @music = Music.new
  end

  def show
  	@music = Music.find(params[:id])
  end

  def create
    @music = Music.new(music_params)
    url = params[:music][:youtube_url]
    if @music.save
      flash[:success] = "新しいmusicが登録されました"
      redirect_to @music
    else
      render 'musics/new'
    end
  end

  def edit
    @music = Music.find(params[:id])
  end

  def update
  	@music = Music.find(params[:id])
  	if @music.update_attributes(music_params)
  		flash[:success] = "更新されました"
  		redirect_to @music
  	end
  end

  def destroy
    @music = Music.find(params[:id])
    if logged_in?
    	@music.destroy
    	flash[:success] = "削除されました"
    	redirect_to root_url
    else
    	flash[:danger] = "管理人しか削除できません"
    	redirect_to @music
    end
  end

  private

    def music_params
      params.require(:music).permit(:name, :info, :date, :youtube_url)
    end

end
