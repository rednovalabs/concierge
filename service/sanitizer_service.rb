class SanitizerService < Service

  def self.sanitize_for_sms message
    message.gsub(/\s{2,}/, ' ')
  end

end
