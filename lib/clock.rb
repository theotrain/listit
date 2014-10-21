# script/workers_schedule.rb

require 'clockwork'

# Require the full rails environment if needed
require './config/boot'
require './config/environment'

include Clockwork

# Define the jobs
handler do |job|
  
  if job.eql?('frequent.send_email')
    puts "prepping #{job} at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"
    Delayed::Job.enqueue(MailingJob.new(4), priority: 0, run_at: 20.seconds.from_now)
  end
# Sessions.cleanup_expired()
# elsif job.eql?('mondays.send_news')
# NewsDispatcher.send_news_to_customers()
# end
end


# Define the schedule
every(30.seconds, 'frequent.send_email')
# every(1.day, 'mondays.send_news', :at => '01:00', :if => lambda { |t| t.wday == 1 })