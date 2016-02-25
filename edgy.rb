require 'sinatra'
require 'twilio-ruby'

require_relative 'lib/chatbot'

require_relative 'service/service'   # core service object
require_relative 'service/bootstrap' # all service derivatives

require_relative 'models/bootstrap'

TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
TWILIO_AUTH_TOKEN  = ENV['TWILIO_AUTH_TOKEN']

edgy = Chatbot.new.tap do |bot|
  bot.set_twilio_credentials TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

  bot.on :message do |message|
    puts "Responding to: #{message}"

    response_template  = KeywordMatcherService.match_to_template message
    puts "Response template: #{response_template}"

    replaced_response  = TemplateReplacerService.replace_replacements response_template
    puts "Replaced response: #{replaced_response}"

    sanitized_response = SanitizerService.sanitize_for_sms replaced_response

    puts "Response generated: #{sanitized_response}"
    sanitized_response
  end
end

get '/' do
  content_type 'text/html'

  "Hello, my name is #{Bot.new[:name]}!"
end

post '/receive_sms' do
  content_type 'text/xml'

  response = Twilio::TwiML::Response.new do |response|
    response.Message edgy.response_for({
      from: params['From'],
      body: params['Body']
    })
  end

  response.to_xml
end
