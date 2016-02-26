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
    #puts "Responding to: #{message}"

    response_template  = KeywordMatcherService.match_to_template message
    #puts "Response template: #{response_template}"

    replaced_response  = TemplateReplacerService.replace_replacements response_template
    #puts "Replaced response: #{replaced_response}"

    sanitized_response = SanitizerService.sanitize_for_sms replaced_response

    #puts "Response generated: #{sanitized_response}"
    sanitized_response
  end
end

get '/' do
  content_type 'text/html'

  "Hello, my name is #{Bot.new[:name]}!"
end

get '/welcome' do
  content_type 'text/html'

  return "No ?phone param" unless params.key? 'phone'

  welcome_template = "<<welcome me>>"
  replaced_template = TemplateReplacerService.replace_replacements welcome_template
  sanitized_response = SanitizerService.sanitize_for_sms replaced_template

  edgy.send_twilio_message sanitized_response, params['phone']
end

post '/receive_sms' do
  content_type 'text/xml'

  response_from_edgy = edgy.response_for({ from: params['From'], body: params['Body'] })

  puts "\n-----"
  puts "Received SMS from #{params['From']}: #{params['Body']}"
  puts "Responding: #{response_from_edgy}"

  response = Twilio::TwiML::Response.new do |response|
    response.Message response_from_edgy
  end

  response.to_xml
end

get '/customize' do
  content_type 'text/html'

  triggers_and_templates = KeywordMatcherService.triggers_and_templates.sort_by { |r| r["enabled"] ? 0 : 1 }
  erb :customize, locals: { triggers_and_templates: triggers_and_templates }
end

post '/update_script' do
  content_type 'text/html'

  # Find the response being edited
  response = KeywordMatcherService.triggers_and_templates.detect do |r|
    %w(trigger template).all? { |x| r[x] == params[x] }
  end

  # And edit it
  if response
    response["template"] = params["new_template"]
    redirect to('/customize')
  else
    "Error"
  end
end

get '/reset_all_templates' do
  KeywordMatcherService.triggers_and_templates reload: true
  redirect to('/customize')
end
