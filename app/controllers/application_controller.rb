class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :logged_in_as_creator?
  helper_method :user_time_zone_offset, :decimal_to_time_zone

  def decimal_to_time_zone(deci)
    leading_sign='+'
    if deci.start_with?('+','-')
      leading_sign = deci.slice!(0)
    end
    hours_section = deci.split('.')[0].rjust(2, "0")
    minutes_section = deci.split('.')[1] == nil ? '00' : deci.split('.')[1].ljust(2, "0")
    leading_sign+hours_section+minutes_section
  end

  def logged_in?
    !!current_user
  end

  def current_user
    # if theres an authenticated user, return user object else nil
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !logged_in?
      flash[:error] = 'Must be logged in to do that.'
      redirect_to root_path
    end
  end

  def require_item_creator
    if current_user.id != @item.user_id
      access_denied
    end
  end

  def logged_in_as_creator?(obj)
    logged_in? && (current_user.id == obj.user_id)
  end

  def require_same_user
    if current_user != @user
      access_denied
    end
  end

  def access_denied
    flash[:error] = "You can't perform that action."
    if logged_in? 
      redirect_to list_user_path(current_user)
    else
      redirect_to root_path
    end
  end

  def ItemDeactivate
    flash[:notice] = "we got to item deactive"
    redirect_to :back
  end

  def user_time_zone_offset
    if logged_in?
      @user_time_zone_offset = (Time.now.in_time_zone(current_user.time_zone).utc_offset/(60.0*60)).to_s.gsub('.',':')
    end
  end

end
