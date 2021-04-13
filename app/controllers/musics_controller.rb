class MusicsController < ApplicationController

  def new
    @music = Music.new
  end

  def show
  	@music = Music.find(params[:id])
  end

  def create
    @music = Music.new(music_params)
    if @music.save
      flash[:success] = "新しいmusicが登録されました"
      redirect_to root_url
    else
      render 'musics/new'
    end
  end

  private

    def music_params
      params.require(:music).permit(:name, :info, :date, :youtube_url)
    end

end
