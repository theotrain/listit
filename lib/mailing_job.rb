class MailingJob
  require 'mailgun'
  require 'twilio-ruby'
  attr_accessor :item_id

  def initialize(item_id)
     self.item_id = item_id
  end

  def perform
    sendEmail
  end

  def sendEmail
    # puts "Running DELAYED JOB at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"
    puts "sending BODY: #{ Item.find(item_id).body }"
    item = Item.find(item_id)
    # Get your Account Sid and Auth Token from twilio.com/user/account
    account_sid = 'AC2f0f554168e2f355ed6b642d6ce86c2a'
    auth_token = '5b6c6e03444ed1381dd757ccf34ccfcc'
    @client = Twilio::REST::Client.new account_sid, auth_token
     
    message = @client.account.messages.create(:body => item.body + "\n" + "http://goo.gl/eKFklp",
        :to => item.user.phone,
        :from => "+19717035399"
        )
    puts message.to
    
    # mg_client = Mailgun::Client.new "key-d78467f903c56cbc59c84d96f21b7307"

    # message_params = {:from    => 'hi from listit! <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>',  
    #                   :to      => 'owen <owen.sacafotos@gmail.com>',
    #                   :subject => 'the really real!',
    #                   :text    => "Sent w/ clockwork from mailing job!  Item body REALS #{ Item.find(item_id).body } ----- item_id passed: (#{item_id}) ----- sent at #{ Time.now }  ----- zone offset #{ Item.find(item_id).time_zone_offset }"}

    # mg_client.send_message "sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org", message_params


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

