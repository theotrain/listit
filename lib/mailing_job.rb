class MailingJob < Struct.new(:item_id)

  def perform
    sendEmail
  end

  def sendEmail
    puts "Running DELAYED JOB at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"

    RestClient.post "https://api:key-d78467f903c56cbc59c84d96f21b7307"\
    "@api.mailgun.net/v2/sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org/messages",
    :from => "hi from clockwork <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>",
    :to => "owen <owen.sacafotos@gmail.com>",
    :subject => "Hello owen",
    :text => "sent with clockwork from mailing job!  sent at #{ Time.now.in_time_zone("Pacific Time (US & Canada)") }"
  end

end