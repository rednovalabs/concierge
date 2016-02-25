module Twilio
  require 'twilio-ruby' #todo Gemfile

  def set_twilio_credentials account_sid, auth_token
    puts "Setting twilio credentials: #{account_sid}, #{auth_token}"
    @twilio_account_sid = account_sid
    @twilio_auth_token  = auth_token
    @twilio_client      = Twilio::REST::Client.new account_sid, auth_token
  end

  # Send twilio message without an incoming message
  def send_twilio_message message, number
    raise "Unable to send Twilio message without setting Twilio credentials" unless @twilio_client

    puts "Sending #{message} to #{number}"
    @twilio_client.account.messages.create({
      from: Bot.new[:twilio_phone],
      to:   number,
      body: message
    })
    puts "Message sent."
  #rescue
  #  puts "Message failed to send."
  end
end
