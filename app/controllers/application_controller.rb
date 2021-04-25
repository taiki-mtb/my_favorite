class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_q

  def set_q
    @q = Dance.ransack(params[:q])
    @results = @q.result
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
