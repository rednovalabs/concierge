module Twilio
  require 'twilio-ruby' #todo Gemfile

  def set_twilio_credentials account_sid, auth_token
    @twilio_account_sid = account_sid
    @twilio_auth_token  = auth_token
    @twilio_client      = Twilio::REST::Client.new account_sid, auth_token
  end

  def get_twilio_messages
    ["yo", "sup", "I am your father"]

    #todo
  end

  def send_twilio_message message
    puts "Sending #{message}"

    #todo
  end
end
