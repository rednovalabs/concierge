class SanitizerService < Service

  def self.sanitize_for_sms message
    "#{message.downcase.gsub('you', 'u')} lol"
    #todo
  end

end