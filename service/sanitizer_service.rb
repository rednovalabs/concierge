class SanitizerService < Service

  def self.sanitize_for_sms message
    "#{message.downcase} lol"
    #todo
  end

end
