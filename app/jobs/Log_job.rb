class Job
  include SuckerPunch::Job

  def perform(data)
    if data.eql?('aaa')
    sleep 2
    puts data
    send_simple_message
  end

  def send_simple_message
  RestClient.post "https://api:key-d78467f903c56cbc59c84d96f21b7307"\
  "@api.mailgun.net/v2/sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandboxe4171dd1b23b440ab9bf21a4b51cb487.mailgun.org>",
  :to => "owen <owen.sacafotos@gmail.com>",
  :subject => "Hello owen",
  :text => "first email with Heroku/Mailgun!  sent at #{ Time.nowTime.now.in_time_zone("Pacific Time (US & Canada)") }"
end

  def later(sec, data)
    after(sec) { perform(data) }
  end
end

Job.new.async.perform("aaaa")
# Job.new.async.later(60, "asdf") # `perform` will be excuted 60 sec. later