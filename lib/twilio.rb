module Twilio
  require 'twilio-ruby' #todo Gemfile

  def set_twilio_credentials account_sid, auth_token
    puts "Setting twilio credentials: #{account_sid}, #{auth_token}"
    @twilio_account_sid = account_sid
    @twilio_auth_token  = auth_token
    @twilio_client      = Twilio::REST::Client.new account_sid, auth_token
  end

  def get_twilio_messages
    [
      {
        from: '+14174561575',
        body: 'yo'
      }
    ]
    #todo
  end

  def send_twilio_message message, number
    raise "Unable to send Twilio message without setting Twilio credentials" unless @twilio_client

    puts "Sending #{message} to #{number}"
    @twilio_client.account.messages.create({
      from: Bot.new[:phone],
      to:   number,
      body: message
    })
    puts "Message sent."
  #rescue
  #  puts "Message failed to send."
  end
end
