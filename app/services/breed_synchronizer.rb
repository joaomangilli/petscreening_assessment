class BreedSynchronizer
  attr_reader :url, :finder

  def initialize(url:, finder:)
    @url = url
    @finder = finder
  end

  def self.synchronize(url:, finder: BreedFinder.new(url:), &block)
    new(url:, finder:).synchronize(&block)
  end

  def synchronize
    yield finder.next_page if block_given? && finder.next_page.present?

    Breed.upsert_all(finder.find, unique_by: :name)
  end
end
