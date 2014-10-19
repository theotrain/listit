class UsersController < ActiveRecord::ApplicationController

def index

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
  :text => "first email with Heroku/Mailgun!  sent at #{ Time.now }"
end

def list
  # binding.pry
  @items = Item.where(user_id: params[:id]).order('items.position ASC')
end

def sort
  # rewrite when current_user is really working in the session
  current_user = 1
  @items = Item.where(user_id: current_user)

  @items.each do |item|
    item.position = params['item'].index(item.id.to_s) + 1
    item.save
  end

  render :nothing => true
end

end