require_relative 'lib/chatbot'

require_relative 'service/service'   # core service object
require_relative 'service/bootstrap' # all service derivatives

require_relative 'models/bootstrap'

TWILIO_ACCOUNT_SID = 'foo'
TWILIO_AUTH_TOKEN  = 'bar'

edgy = Chatbot.new.tap do |bot|
  bot.set_twilio_credentials TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

  bot.on :message do |message|
    puts "Responding to: #{message}"

    response_template  = KeywordMatcherService.match_to_template message
    replaced_response  = TemplateReplacerService.replace_replacements response_template
    sanitized_response = SanitizerService.sanitize_for_sms replaced_response

    puts "Response generated: #{sanitized_response}"
    sanitized_response
  end
end
edgy.enliven!
