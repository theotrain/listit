class MailingJob
  require 'mailgun'
  attr_accessor :item_id

  def initialize(item_id)
     self.item_id = item_id
  end

  def perform
    sendEmail
  end

  def sendEmail
    # puts "Running DELAYED JOB at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"
    # puts "sending BODY: #{ Item.find(item_id).body }"

    # RestClient.post "https://api:key-d78467f903c56cbc59c84d96f21b7307"\
    # "@api.mailgun.net/v2/sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org/messages",
    # :from => "hi from clockwork <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>",
    # :to => "owen <owen.sacafotos@gmail.com>",
    # :subject => "yeehaw, it was really scheduled",
    # :text => "Sent w/ clockwork from mailing job!  Item body REALS #{ Item.find(item_id).body } ----- item_id passed: (#{item_id}) ----- sent at #{ Time.now.in_time_zone("Pacific Time (US & Canada)") }"
    mg_client = Mailgun::Client.new "key-d78467f903c56cbc59c84d96f21b7307"

    # Define your message parameters
    message_params = {:from    => 'hi from listit! <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>',  
                      :to      => 'owen <owen.sacafotos@gmail.com>',
                      :subject => 'the really real!',
                      :text    => "Sent w/ clockwork from mailing job!  Item body REALS #{ Item.find(item_id).body } ----- item_id passed: (#{item_id}) ----- sent at #{ Time.now.in_time_zone('Pacific Time (US & Canada)') }"}

    # Send your message through the client
    mg_client.send_message "sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org", message_params


  end

  # def sendEmail
  #   puts "Running DELAYED JOB at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"
  #   puts "sending BODY: #{ Item.find(item_id).body }"
  #   RestClient.post "https://api:key-d78467f903c56cbc59c84d96f21b7307"\
  #   "@api.mailgun.net/v2/sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org/messages",
  #   :from => "hi from clockwork <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>",
  #   :to => "owen <owen.sacafotos@gmail.com>",
  #   :subject => "yeehaw, it was really scheduled",
  #   :text => "Sent w/ clockwork from mailing job!  Item body REALS #{ Item.find(item_id).body } ----- item_id passed: (#{item_id}) ----- sent at #{ Time.now.in_time_zone("Pacific Time (US & Canada)") }"
  # end

end

