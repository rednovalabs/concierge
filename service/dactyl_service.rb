class DactylService < Service

  METRICS_WE_WANT_TO_ANALYZE = [
    'sentiment',
    'sentiment_score'
  ]

  def self.analyze message
    uri = URI.parse("http://www.dactyl.in/api/v1/dactyl?text=#{message}#{metric_url_filter}")
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    begin
      JSON.parse(response.body)["metrics"]
    rescue
      { # some default data
        sentiment: 'neutral',
        sentiment_score: 0.0
      }
    end
  end

  private

  def metric_url_filter
    METRICS_WE_WANT_TO_ANALYZE.map { |metric| "&metrics[]=#{metric}" }.join
  end
end
