class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_q

  def set_q
    @q_dance = Dance.ransack(params[:q])
    @q_music = Music.ransack(params[:q])
    @q_stage = Stage.ransack(params[:q])
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to root_url
      end
    end
end
