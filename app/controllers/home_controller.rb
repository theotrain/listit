class HomeController < ApplicationController

def index
  if logged_in?
    redirect_to list_user_path(current_user)
  end
end



end