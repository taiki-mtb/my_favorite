class CommentsController < ApplicationController

  def create
  	if !params[:dance_id].nil?
      @dance = Dance.find(params[:dance_id])
      @comment = @dance.comments.build(content: params[:comment][:content])
    elsif !params[:music_id].nil?
      @music = Music.find(params[:music_id])
      @comment = @music.comments.build(content: params[:comment][:content])
    elsif !params[:stage_id].nil?
      @stage = Stage.find(params[:stage_id])
      @comment = @stage.comments.build(content: params[:comment][:content])
    end
  	if @comment.save
    	flash[:success] = "コメントしました！"
    else
    	flash[:danger] = "空のコメントは投稿できません"
    end
    redirect_to request.referrer
  end
  # def create
  	# if @dance = Dance.find(params[:dance_id])
      # @comment = @dance.comments.build(content: params[:comment][:content])
    # elsif @music = Music.find(params[:music_id])
      # @comment = @music.comments.build(content: params[:comment][:content])
    # elsif @stage = Stage.find(params[:stage_id])
      # @comment = @stage.comments.build(content: params[:comment][:content])
    # end
    # if @comment.save
    	# flash[:success] = "コメントしました！"
    # else
    	# flash[:danger] = "空のコメントは投稿できません"
    # end
    # redirect_to request.referrer
  # end

  def destroy
    @comment = Comment.find(params[:id])
    if !params[:dance_id].nil?
      @dance = @comment.dance
    elsif !params[:music_id].nil?
      @music = @comment.dance
    elsif !params[:stage_id].nil?
      @stage = @comment.dance
    end
    if logged_in?
      @comment.destroy
      flash[:success] = "コメントを削除しました"
      redirect_to request.referer
    end
  end
end
