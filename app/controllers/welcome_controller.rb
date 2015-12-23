class WelcomeController < ApplicationController
  def index
    user = current_user
    if user_signed_in?
      redirect_to user_path(user)
    end
  end

  def about
  end
end
