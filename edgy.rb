require_relative 'lib/chatbot'
require_relative 'lib/storedge'

require_relative 'models/bootstrap'

TWILIO_ACCOUNT_SID = 'foo'
TWILIO_AUTH_TOKEN  = 'bar'

edgy = Chatbot.new.tap do |bot|
  bot.set_twilio_credentials TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

  bot.on :message do |message|

    "Responding to message: #{message}"
  end
end
edgy.enliven!
