module HttpConnection
  class Adapter
    class Error < StandardError; end

    def self.get(url:)
      response = Faraday.get(url)
      JSON.parse(response.body).with_indifferent_access
    rescue Faraday::Error => e
      raise Error.new(e)
    end
  end
end
