class ArtistsController < ApplicationController
  before_action :logged_in_user, exept: :show

  def new
    @artist = Artist.new
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def create
    @artist = Artist.create(artist_params)
    if @artist.save
      flash[:success] = "新しいartistが登録されました"
      redirect_to @artist
    else
      render 'artists/new'
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(artist_params)
      flash[:success] = "更新されました"
      redirect_to @artist
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    if @artist.destroy
      flash[:success] = "削除されました"
      redirect_to root_url
    else
      flash[:danger] = "管理人しか削除できません"
      redirect_to @dance
    end
  end

  private

    def artist_params
      params.require(:artist).permit(:name, :info, images: [])
    end
end
