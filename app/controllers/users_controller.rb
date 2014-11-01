class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :list]
  before_action :require_same_user, only: [:edit, :update, :list]


  def new
    @user = User.new
  end

  def show

  end

  def edit

  end

  def update
    # binding.pry
    if @user.update(user_params)
      flash[:notice] = "Profile has been updated."
      redirect_to list_user_path(@user)
    else
      render :edit
    end
  end

  def create
    #binding.pry
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You are registered and logged in as '#{params[:user][:username]}'."
      session[:user_id] = @user.id
      redirect_to list_user_path(@user)
    else
      render :new
    end
  end

  def email
    send_simple_message
    @var = "something from the action"
  end

  def send_simple_message
    RestClient.post "https://api:key-d78467f903c56cbc59c84d96f21b7307"\
    "@api.mailgun.net/v2/sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>",
    :to => "owen <owen.sacafotos@gmail.com>",
    :subject => "Hello owen",
    :text => "first email with Heroku/Mailgun!  sent at #{ Time.now.in_time_zone("Pacific Time (US & Canada)") }"
  end

  def list
     # binding.pry

    @items = User.find_by(slug: params[:id]).items.order('items.position ASC')
  end

  def sort
    @items = Item.where(user_id: current_user)

    @items.each do |item|
      item.position = params['item'].index(item.id.to_s) + 1
      item.save
    end

    render :nothing => true
  end

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

end