# script/workers_schedule.rb
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)

require 'clockwork'
# require 'mailgun'

# Require the full rails environment if needed
# require './config/boot'
# require './config/environment'

include Clockwork

frequency_in_seconds = 60

# Define the jobs
handler do |job|
  
  if job.eql?('frequent.send_email')
    puts "clockwork task triggered"
    #puts "prepping #{job} at #{Time.now.in_time_zone("Pacific Time (US & Canada)")}"
    #Delayed::Job.enqueue(MailingJob.new(4), priority: 0, run_at: 20.seconds.from_now)
    # Delayed::Job.enqueue(MailingJob.new(Item.last.id), priority: 0)
    

    # Delayed::Job.enqueue(MailingJob.new(Item.first.id), priority: 0)
    schedule_jobs
  end
end


def seconds_to_days(sec)
  # 1 second is worth this many days = 1.0 / (60 * 60 * 24)
  sec * (1.0/86400)
end

  
def schedule_jobs

  frequency_in_seconds = 60

  now_time_utc = DateTime.now.utc
  send_items = Item.where("sms_time < ? AND active = ? AND sms_sent = ?", now_time_utc + seconds_to_days(frequency_in_seconds), true, false)
  send_items.each do |i|
    if i.sms_time.to_datetime > now_time_utc
      # schedule this item for the future
      # subtracting datetimes gives result in days, convert to seconds then round to integer
      seconds_to_delay = (1.0 * (i.sms_time.to_datetime - now_time_utc) * 24 * 60 * 60).to_i
      puts "passing delayed queued job (#{seconds_to_delay} seconds) --- #{i.body}"
      Delayed::Job.enqueue(MailingJob.new(i.id), priority: 0, run_at: seconds_to_delay.seconds.from_now)
      i.update(sms_sent: true)
    else
      # send immediately
      puts "Passing immediate queued job --- #{i.body}"

      Delayed::Job.enqueue(MailingJob.new(i.id), priority: 0)
      i.update(sms_sent: true)
    end
  end
end


# Define the schedule
 every(frequency_in_seconds.seconds, 'frequent.send_email')
# every(1.day, 'mondays.send_news', :at => '01:00', :if => lambda { |t| t.wday == 1 })