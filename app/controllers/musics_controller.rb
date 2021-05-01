class MusicsController < ApplicationController
  before_action :logged_in_user, except: [:show, :tag, :list, :search]

  def new
    @music = Music.new
  end

  def show
    @music = Music.find(params[:id])
    @music_tags = @music.tags
    @music_lists = @music.lists
    @comment = Comment.new
  end

  def search
    @results = @q_music.result
  end

  def tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @musics = @tag.musics.all
  end

  def list
    @list_all = List.all
    @list = List.find(params[:list_id])
    @musics = @list.musics.all
  end

  def create
    @music = Music.new(music_params)
    tag_list = params[:music][:tag_name].split(',')
    list_all = params[:music][:list_name].split(',')
    if @music.save
      @music.save_tag(tag_list)
      @music.save_list(list_all)
      flash[:success] = "新しいmusicが登録されました"
      redirect_to @music
    else
      render 'musics/new'
    end
  end

  def edit
    @music = Music.find(params[:id])
    @tag_list = @music.tags.pluck(:tag_name).join(',')
    @list_all = @music.lists.pluck(:list_name).join(',')
  end

  def update
    @music = Music.find(params[:id])
    tag_list = params[:music][:tag_name].split(',')
    list_all = params[:music][:list_name].split(',')
    if @music.update_attributes(music_params)
      @music.save_tag(tag_list)
      @music.save_list(list_all)
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
