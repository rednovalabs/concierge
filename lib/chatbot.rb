require_relative 'twilio' # for sms sending/receiving

class Chatbot
  include Twilio

  # Whether or not to print debug output to console
  DEBUG_OUTPUT = false

  def initialize
    @handlers = {}
  end

  def response_for message
    debug "Finding response for '#{message}'"

    response = @handlers[:message].collect do |handler|
      handler.call(message[:body])
    end.compact.join ''

    debug "Responding with: #{response}"
    response
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
