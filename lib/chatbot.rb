require_relative 'twilio' # for sms sending/receiving

class Chatbot
  include Twilio

  # Seconds between queries to Twilio to look for new messages
  SNOOZE_SECONDS = 5

  # Whether or not to print debug output to console
  DEBUG_OUTPUT = true

  def initialize
    @handlers = {}
  end

  def enliven!
    debug "Starting chat bot..."
    listen_for_messages!
  end

  def listen_for_messages!
    #todo might need to spin up a server instead if twilio needs a callback url
    # for posting messages
    loop do
      debug "Checking for messages..."

      messages = get_twilio_messages
      if messages.any?
        debug "Found #{messages.count} message(s)."
        messages.each { |message| respond_to message }
      end

      debug "Sleeping for #{SNOOZE_SECONDS} seconds."
      sleep SNOOZE_SECONDS
    end
  end

  def respond_to message
    debug "Responding to '#{message}'"

    response = @handlers[:message].collect do |handler|
      handler.call(message[:body])
    end.compact.join ' | '

    debug "Responding with: #{response}"
    send_twilio_message response, message[:from]
  end

  # Store proc blocks to run on named hooks
  def on trigger, &block
    @handlers[trigger] = [] unless @handlers.key? trigger
    @handlers[trigger] << block
  end

  private

  def debug message
    puts "[#{Time.now.getutc}] #{message}" if DEBUG_OUTPUT
  end

end
