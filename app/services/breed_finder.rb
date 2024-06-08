class BreedFinder
  attr_reader :url, :adapter

  def initialize(url:, adapter: HttpConnection::Adapter)
    @url = url
    @adapter = adapter
  end

  def next_page
    data.dig(:links, :next)
  end

  def find
    data[:data].to_a.map do |breed|
      attributes = breed[:attributes]
      next if attributes.nil?

      {
        name: attributes[:name],
        description: attributes[:description],
        life_min: attributes.dig(:life, :min),
        life_max: attributes.dig(:life, :max),
        male_weight_min: attributes.dig(:male_weight, :min),
        male_weight_max: attributes.dig(:male_weight, :max),
        female_weight_min: attributes.dig(:female_weight, :min),
        female_weight_max: attributes.dig(:female_weight, :max),
        hypoallergenic: attributes[:hypoallergenic] || false
      }
    end.compact
  end

  private

    def data
      @data ||= adapter.get(url:)
    end
end
