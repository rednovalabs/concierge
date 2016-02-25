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

get '/welcome' do
  content_type 'text/html'

  return "No ?phone param" unless params.key? 'phone'

  welcome_template = [
    "Welcome to [[facility.name]], [[tenant.first_name]]!",
    "I'm [[bot.name]] and I'm here to help you --",
    "just text me any time with any questions you have,",
    "and I'll do my best to answer you!"
  ].join ' '
  replaced_template = TemplateReplacerService.replace_replacements welcome_template
  sanitized_response = SanitizerService.sanitize_for_sms replaced_template

  edgy.send_twilio_message sanitized_response, params['phone']
end

post '/receive_sms' do
  content_type 'text/xml'

  puts "Receieved SMS from #{params['From']}: #{params['Body']}"

  response = Twilio::TwiML::Response.new do |response|
    response.Message edgy.response_for({
      from: params['From'],
      body: params['Body']
    })
  end

  response.to_xml
end

get '/help' do
  content_type 'text/html'

  response_table = [
    "<table border='1' width='100%'><tr>" + %w(Trigger Template Context Restriction Enabled?).map { |h| "<th>#{h}</th>" }.join + "</tr>"
  ]
  KeywordMatcherService.triggers_and_templates.each do |response|
    response_table << "<tr>" + %w(trigger template context_restriction set_context enabled).map { |a| "<td>#{response[a]}</td>" }.join + "</tr>"
  end

  response_table.join
end
