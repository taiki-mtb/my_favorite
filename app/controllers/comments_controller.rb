class CommentsController < ApplicationController

  def create
  	@dance = Dance.find(params[:dance_id])
    @comment = @dance.comments.build(content: params[:comment][:content])
  	if !@dance.nil? && @comment.save
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
    @dance = @comment.dance
    if logged_in?
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to dance_url(@dance)
  end
end
